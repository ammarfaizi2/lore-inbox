Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbULGAXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbULGAXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbULGAWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:22:47 -0500
Received: from main.gmane.org ([80.91.229.2]:6803 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261711AbULGAVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:21:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: Booting 2.6.10-rc3
Date: Tue, 07 Dec 2004 00:13:57 +0000
Organization: World Organi[sz]ation Of Broken Dreams
Message-ID: <cp2sk5$61r$2@sea.gmane.org>
References: <1102256916.29858.210104494@webmail.messagingengine.com>   <41B36A5D.50901@verizon.net> <1102322642.18071.210148617@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: apogee.jonmasters.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
In-Reply-To: <1102322642.18071.210148617@webmail.messagingengine.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Cc: kernelnewbies@nl.linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anandraj wrote:

> Now it works after makingsome changes in the grub.conf
> 
> all i did was, in the grub.conf changed the 
> 
> kernel /vmlinuz-2.6.10-rc3 ro root=LABLE=/ rhgb quiet
> 
> to 
> 
> kernel /vmlinuz-2.6.10-rc3
> 
> but, i have no idea , this works!
> can anybody shed some light on this ?

There's a repeated typo in your root=LABLE=/ entry, since it should be 
LABEL instead of LABLE.

That entry tells the kernel to look for a filesystem which contains a 
label in its superblock that matches the one you gave via grub.

Cheers,

Jon.


