Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318539AbSHEOpz>; Mon, 5 Aug 2002 10:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318541AbSHEOpz>; Mon, 5 Aug 2002 10:45:55 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:16634 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318539AbSHEOpz>; Mon, 5 Aug 2002 10:45:55 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.NEB.4.44.0208051638340.27501-100000@mimas.fachschaften.tu-muenchen.de> 
References: <Pine.NEB.4.44.0208051638340.27501-100000@mimas.fachschaften.tu-muenchen.de> 
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.30-dj1 (sort of) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Aug 2002 15:48:44 +0100
Message-ID: <29481.1028558924@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bunk@fs.tum.de said:
>  Below is the output of
>   filterdiff -z -i \*jffs2\* patch-2.5.30-dj1.diff.gz 

Thanks.

> --- linux-2.5.30/fs/jffs2/background.c	2002-08-01 22:16:02 +0100 
> +++ linux-2.5/fs/jffs2/background.c	2002-08-02 15:50:33 +0100

Applied. 

> --- linux-2.5.30/fs/jffs2/dir.c	2002-08-01 22:16:15.000000000 +0100
> +++ linux-2.5/fs/jffs2/dir.c	2002-08-02 15:50:33.000000000 +0100

This is a duplicate -- it's already in Linus' tree. You noticed the line 
which actually stopped it compiling; the other hunk is bogus too.

--
dwmw2


