Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSATQbD>; Sun, 20 Jan 2002 11:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288804AbSATQay>; Sun, 20 Jan 2002 11:30:54 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:14557 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S288800AbSATQaj>; Sun, 20 Jan 2002 11:30:39 -0500
Date: Sun, 20 Jan 2002 17:29:26 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: David Woodhouse <dwmw2@infradead.org>
cc: Momchil Velikov <velco@fadata.bg>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] __linux__ and cross-compile 
In-Reply-To: <2385.1011543302@redhat.com>
Message-ID: <Pine.NEB.4.44.0201201719060.20948-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, David Woodhouse wrote:

>...
> > But if yes please consider what the following parts of your patch change:
> > -#ifndef __linux__
> > +#ifndef __KERNEL__
>
> Well, if he hadn't explicitly mentioned that he made header files which
> could be included by userspace use defined(__KERNEL__)||defined(__linux__)
> then I'd understand what you meant. As it is, I don't. Please explain.

This is part of his patch to drivers/scsi/aic7xxx/aic7xxx.c

It's clear that code that is part of an "#ifndef __linux__" will never be
included on any other OS than Linux. Is this also garuanteed for
"#ifndef __KERNEL__"?

> dwmw2

cu
Adrian




