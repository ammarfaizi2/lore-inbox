Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751945AbWG0Swh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbWG0Swh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbWG0Swg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:52:36 -0400
Received: from terminus.zytor.com ([192.83.249.54]:56275 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751945AbWG0Swg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:52:36 -0400
Message-ID: <44C90B6F.5070000@zytor.com>
Date: Thu, 27 Jul 2006 11:52:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: patch for Documentation/initrd.txt?
References: <200607272026.57695.a1426z@gawab.com>
In-Reply-To: <200607272026.57695.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> 
> Thanks for your very useful docPatch!
> 
> OT, but your docPatch made me think of another way to init the kernel; via 
> tmpfs, i.e. initTmpFS.
> 
> Can anybody see how that could be useful?
> 

Useful, yes, but this has turned out to be fairly complex.  tmpfs needs 
a *LOT* more of the system to be fully operational than ramfs, and the 
rootfs is initialized very early on, since one of its purposes is to 
eliminate special cases.

	-hpa
