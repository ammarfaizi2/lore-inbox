Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUBDPqS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 10:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbUBDPqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 10:46:18 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:47876 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261779AbUBDPqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 10:46:17 -0500
Date: Wed, 4 Feb 2004 15:46:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Alexander Viro <aviro@redhat.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
       selinux@tycho.nsa.gov, Chris Wright <chrisw@osdl.org>,
       trond.myklebust@fys.uio.no
Subject: Re: [PATCH] (2/3) SELinux context mount support - NFS
Message-ID: <20040204154608.A19702@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Alexander Viro <aviro@redhat.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
	selinux@tycho.nsa.gov, Chris Wright <chrisw@osdl.org>,
	trond.myklebust@fys.uio.no
References: <Xine.LNX.4.44.0402040931480.4796@thoron.boston.redhat.com> <Xine.LNX.4.44.0402040949010.4796-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Xine.LNX.4.44.0402040949010.4796-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Wed, Feb 04, 2004 at 10:31:51AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 10:31:51AM -0500, James Morris wrote:
> This patch modifies the kernel's NFS mount data structure to include 
> SELinux context mount data.  It allows NFS fileystems to be labeled on a 
> per-mountpoint basis, and should not affect existing versions of 
> userspace mount.

Wouldn't it better to integrate the NFS xattr code that SGI released under
the GPL  (it's IRIX, not linux code unfortunately)

