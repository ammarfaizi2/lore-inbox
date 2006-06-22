Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWFVKSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWFVKSw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWFVKSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:18:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35214 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751775AbWFVKSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:18:50 -0400
Subject: Re: [-mm patch] fs/gfs2/: make code static
From: Steven Whitehouse <swhiteho@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
In-Reply-To: <20060622100324.GZ9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	 <20060622100324.GZ9111@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 22 Jun 2006 11:25:37 +0100
Message-Id: <1150971937.3856.1501.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-06-22 at 12:03 +0200, Adrian Bunk wrote:
> On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.17-rc6-mm2:
> >...
> >  git-gfs2.patch
> >...
> >  git trees
> >...
> 
> This patch makes the following needlessly global code static:
> - eaops.c: struct gfs2_security_eaops
> - rgrp.c: gfs2_free_uninit_di()
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
Thanks for the patch. I've added it to the git tree:

git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6.git

Steve.


