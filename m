Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVA0CSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVA0CSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVAZXp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:45:26 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:14485 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261960AbVAZTFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:05:39 -0500
Date: Wed, 26 Jan 2005 20:05:37 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Akinobu Mita <amgta@yacht.ocn.ne.jp>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] oprofile: falling back on timer interrupt mode
Message-ID: <20050126190537.GA26349@suse.de>
References: <200501260512.j0Q5CAhd016730@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200501260512.j0Q5CAhd016730@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 26, Linux Kernel Mailing List wrote:

> ChangeSet 1.2038, 2005/01/25 20:31:01-08:00, amgta@yacht.ocn.ne.jp
> 
> 	[PATCH] oprofile: falling back on timer interrupt mode

> 
>  arch/alpha/oprofile/common.c     |    6 ++++--
>  arch/arm/oprofile/common.c       |    7 +++++--
>  arch/arm/oprofile/init.c         |    8 ++++++--
>  arch/i386/oprofile/init.c        |    4 +++-
>  arch/ia64/oprofile/init.c        |    8 ++++++--
>  arch/m32r/oprofile/init.c        |    3 ++-
>  arch/parisc/oprofile/init.c      |    3 ++-
>  arch/ppc64/oprofile/common.c     |    6 ++++--
>  arch/s390/oprofile/init.c        |    3 ++-
>  arch/sh/oprofile/op_model_null.c |    3 ++-
>  arch/sparc64/oprofile/init.c     |    3 ++-
>  drivers/oprofile/oprof.c         |    6 +++---
>  include/linux/oprofile.h         |    2 +-
>  13 files changed, 42 insertions(+), 20 deletions(-)

This misses arch/ppc

