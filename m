Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267058AbUBMPfc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267059AbUBMPfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:35:32 -0500
Received: from main.gmane.org ([80.91.224.249]:2442 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267058AbUBMPfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:35:25 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: why are capabilities disabled?
Date: Fri, 13 Feb 2004 16:29:28 +0100
Message-ID: <c0iqrq$erh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd953c90e.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: de, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"getpcaps 1" shows, that the init-process is started without 
cap_setpcap, and i know that i can change that somehow.
So why are capabilities disabled? and how do i enable them?

If capabilities aren't still too unmature, wouldn't it be fine to have 
an option in "make menuconfig" to enable them?

My intention is to a allow a process to bind a port <1024.
The process can't be started as root.

Thx
   Sven

