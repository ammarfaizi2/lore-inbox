Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUK3Qrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUK3Qrw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbUK3QqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:46:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37761 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262183AbUK3Qni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:43:38 -0500
Date: Tue, 30 Nov 2004 11:43:11 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Gerrit Huizenga <gh@us.ibm.com>
cc: linux-kernel@vger.kernel.org, <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] [PATCH] CKRM: 6/10 CKRM:  Resource controller for
 sockets
In-Reply-To: <E1CYqax-000591-00@w-gerrit.beaverton.ibm.com>
Message-ID: <Xine.LNX.4.44.0411301142260.12330-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Gerrit Huizenga wrote:

> +int sock_mkdir(struct inode *, struct dentry *, int mode);
> +int sock_rmdir(struct inode *, struct dentry *);
> +
> +int sock_create_noperm(struct inode *, struct dentry *, int,
> +		       struct nameidata *);
> +int sock_unlink_noperm(struct inode *, struct dentry *);
> +int sock_mkdir_noperm(struct inode *, struct dentry *, int);
> +int sock_rmdir_noperm(struct inode *, struct dentry *);
> +int sock_mknod_noperm(struct inode *, struct dentry *, int, dev_t);
> 

The sock_ namespace belongs to core networking.  Use rcfs_sock_ or 
something.




- James
-- 
James Morris
<jmorris@redhat.com>


