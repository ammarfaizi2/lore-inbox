Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271807AbTHDPFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271808AbTHDPFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:05:33 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:5107 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S271807AbTHDPF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:05:26 -0400
Date: Mon, 4 Aug 2003 17:04:49 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200308041504.h74F4n5o013600@burner.fokus.fraunhofer.de>
To: autobot@bol.com.br, linux-kernel@vger.kernel.org
Cc: schilling@fokus.fraunhofer.de
Subject: Re: CDrecord -> Kernel panic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From ricardo@rio.terra.com.br Mon Aug  4 16:57:45 2003

>	I've been getting several kernel panics due to CD burning.

>        When tried to burn old CD-RWs (4x), sometimes I've got a kernel
>panic. The system told me a bug in the IDE stack (it had been told that
>the problem is in the ide-iops.c file). Fortunately I was using only
>CD-RWs... =3D)
>=09
>	Let me send 2 U my info:
>=09
>cat /proc/version
>Linux version 2.4.21 (root@aragorn.rjp.org.br) (gcc version 3.2.2
>20030222 (Red Hat Linux 3.2.2-5)) #4 Seg Ago 4 10:49:02 BRT 2003

>cdrecord -version
>Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J=F6rg Schilling

Outdated..... 
http://www.fokus.fhg.de/research/cc/glone/employees/joerg.schilling/private/problems.html
... but not the reason for the problem.


Recent 2.4 (>= 2.4.18) Kernels seem to be a nightmare with IDE drivers.
Maybe one of the kernel hackers has an idea. 

As I am just trying to fix a IDE driver too, I know that the change in the IDE 
subsystem caused some functions to be called with a wrong number of args. This 
is most likely the reason for your kernel because the missing ars is a pointer 
;-)

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
