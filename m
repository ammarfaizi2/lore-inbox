Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVA1TDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVA1TDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVA1S7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:59:36 -0500
Received: from lakermmtao02.cox.net ([68.230.240.37]:38310 "EHLO
	lakermmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261515AbVA1S5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:57:11 -0500
Message-ID: <41FA8ADE.6080708@rueb.com>
Date: Fri, 28 Jan 2005 12:56:30 -0600
From: Steve Bergman <steve@rueb.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Performance of iptables-restore on large rule sets
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a large rule set (~53000 rules) that I sometimes load using 
iptables-restore.  (It takes almost an hour.

Googling around tells me that the loop detection code in the kernel is 
slow with large rule sets.  The only thing  that seems odd to me is that 
throughout the entire loading process, iptables-restore is consistently 
at about 67% user and33% system processor time according to vmstat.  If 
the slowness is in the kernel, shouldn't I be seeing a high and ever 
increasing amount of "system" time?

Kernel is 2.6.9-1.681_FC3.  Iptables is iptables-1.2.11-3.1.FC3.

Thanks for any insights,
Steve Bergman
