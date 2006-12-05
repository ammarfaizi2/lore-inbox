Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031402AbWLEVAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031402AbWLEVAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031384AbWLEVAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:00:42 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:52191 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031360AbWLEVAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:00:40 -0500
Date: Tue, 5 Dec 2006 21:53:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 13/35] lookup_one_len_nd - lookup_one_len with nameidata
 argument
In-Reply-To: <11652354701586-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052152170.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354701586-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+++ b/fs/namei.c
>@@ -1290,8 +1290,8 @@ static struct dentry *lookup_hash(struct
> 	return __lookup_hash(&nd->last, nd->dentry, nd);
> }
> 
>-/* SMP-safe */
>-struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
>+struct dentry * lookup_one_len_nd(const char *name, struct dentry * base,
>+				  int len, struct nameidata *nd)

Your style varies between <TYPE> *<NAME> and <TYPE> * <NAME>.
Unify it some time.



	-`J'
-- 
