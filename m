Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWBJEn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWBJEn1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWBJEn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:43:27 -0500
Received: from hera.kernel.org ([140.211.167.34]:7563 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750938AbWBJEn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:43:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] fstatat64 support
Date: Thu, 9 Feb 2006 20:43:05 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dsh5kp$bn$1@terminus.zytor.com>
References: <200602082008.k18K8dqE026598@devserv.devel.redhat.com> <20060208204015.GA25477@infradead.org> <43EA5CCD.7030605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1139546585 376 127.0.0.1 (10 Feb 2006 04:43:05 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 10 Feb 2006 04:43:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <43EA5CCD.7030605@redhat.com>
By author:    Ulrich Drepper <drepper@redhat.com>
In newsgroup: linux.dev.kernel
> 
> Christoph Hellwig wrote:
> > please remove the new from the syscall name.  just sys_fstatat64
> 
> I use that to show the lineage.  We use newfstat etc for the current
> generation of interfaces.  Using fstatat would be irritating IMO.
> 

Eh?

We don't use sys_newfstat for the current generation, we use
sys_fstat64.

This would be the "at" version of sys_fstat64, so the only sane name
of this system call is sys_fstatat64.

	-hpa

