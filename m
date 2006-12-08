Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425361AbWLHLCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425361AbWLHLCV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425356AbWLHLCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:02:21 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:60261 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938029AbWLHLCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:02:19 -0500
Date: Fri, 8 Dec 2006 11:53:07 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 35/35] Unionfs: Extended Attributes support
In-Reply-To: <20061208053500.GE14363@filer.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612081152460.20988@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <1165235473964-git-send-email-jsipek@cs.sunysb.edu>
 <Pine.LNX.4.61.0612071202360.2863@yvahk01.tjqt.qr>
 <20061208053500.GE14363@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Dec 8 2006 00:35, Josef Sipek wrote:
>> 
>> >--- a/fs/unionfs/copyup.c
>> >+++ b/fs/unionfs/copyup.c
>> >@@ -18,6 +18,75 @@
>> > 
>> > #include "union.h"
>> > 
>> >+#ifdef CONFIG_UNION_FS_XATTR
>> 
>> ^^ this, do you?.
> 
>Beware, copyup.c gets compiled all the time even when you don't have xattrs
>enabled.

Oops, I thought this was xattr.c. Sorry for the noise.

	-`J'
-- 
