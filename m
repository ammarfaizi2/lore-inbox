Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVHMKGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVHMKGb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 06:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVHMKGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 06:06:31 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:23502 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S932142AbVHMKGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 06:06:30 -0400
Date: Sat, 13 Aug 2005 12:06:16 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: 7eggert@gmx.de, harvested.in.lkml@7eggert.dyndns.org,
       vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org
Subject: Re: Problem with usb-storage and /dev/sd?
In-Reply-To: <20050812103832.28ff17a0.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.58.0508131149070.2192@be1.lrz>
References: <4pzyn-10f-33@gated-at.bofh.it> <4AubX-4w6-9@gated-at.bofh.it>
 <E1E3X6P-0000cN-BB@be1.lrz> <20050812103832.28ff17a0.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005, Pete Zaitcev wrote:

> On Fri, 12 Aug 2005 12:49:28 +0200, Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org> wrote:
> 
> > Which label will a random USB stick have?
> 
> GUID, I presume.

A global unique ID won't work out to make all USB mass storage devices
appear under a common mountpoint, especially if it is recreated while
"formating" it.

-- 
The enemy diversion you have been ignoring will be the main attack. 
