Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVBXKN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVBXKN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVBXKMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:12:02 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:31142 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262134AbVBXJdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:33:37 -0500
To: James Morris <jmorris@redhat.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [ckrm-tech] [PATCH] CKRM: 6/10 CKRM: Resource controller for sockets 
In-reply-to: Your message of Tue, 30 Nov 2004 11:43:11 EST.
             <Xine.LNX.4.44.0411301142260.12330-100000@thoron.boston.redhat.com> 
Date: Thu, 24 Feb 2005 01:33:34 -0800
Message-Id: <E1D4FNG-0006vU-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Nov 2004 11:43:11 EST, James Morris wrote:
> On Mon, 29 Nov 2004, Gerrit Huizenga wrote:
> 
> > +int sock_mkdir(struct inode *, struct dentry *, int mode);
> > +int sock_rmdir(struct inode *, struct dentry *);
> > +
> > +int sock_create_noperm(struct inode *, struct dentry *, int,
> > +		       struct nameidata *);
> > +int sock_unlink_noperm(struct inode *, struct dentry *);
> > +int sock_mkdir_noperm(struct inode *, struct dentry *, int);
> > +int sock_rmdir_noperm(struct inode *, struct dentry *);
> > +int sock_mknod_noperm(struct inode *, struct dentry *, int, dev_t);
> > 
> 
> The sock_ namespace belongs to core networking.  Use rcfs_sock_ or 
> something.

Very good point.  Global search and destroy, er, replace applied.

gerrit
