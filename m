Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVCKTUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVCKTUC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVCKTLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:11:07 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:42964 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261328AbVCKTF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:05:28 -0500
Message-ID: <4231EBC7.9050901@nortel.com>
Date: Fri, 11 Mar 2005 13:04:39 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 3/9] UML - "Hardware" random number generator
References: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org>  <200503101341.37346.rob@landley.net> <200503111845.j2BIjkJp003341@ccure.user-mode-linux.org>
In-Reply-To: <200503111845.j2BIjkJp003341@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> rob@landley.net said:
> 
>>I'm just thinking about those UML hosting farms, with several UML
>>instances  per machine, on machines which haven't got a keyboard
>>attached constantly  feeding entropy into the pool.

That's when you set the network links to feed entropy.  It may not be 
very good entropy, but it's probably better than nothing (especially in 
a UML virtual-system instance, where the real NIC is handling traffic 
for all hosted systems).

Chris
