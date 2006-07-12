Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWGLBcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWGLBcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 21:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWGLBcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 21:32:52 -0400
Received: from compunauta.com ([69.36.170.169]:40068 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S1750948AbWGLBcw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 21:32:52 -0400
From: Gustavo Guillermo =?iso-8859-15?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: linux-kernel@vger.kernel.org
Subject: Re: Pentium D on GW fail to boot with 2.6.16/17 but not with 2.6.11/12/13/14/15
Date: Tue, 11 Jul 2006 20:32:50 -0500
User-Agent: KMail/1.8.2
References: <200607111906.06343.gustavo@compunauta.com>
In-Reply-To: <200607111906.06343.gustavo@compunauta.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607112032.51788.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewing my experiments I was discover that the problem start at 2.6.16, 
cause going forward from 2.6.11 to 2.6.15 there is no problem in smp or 
single mode.

El Martes, 11 de Julio de 2006 19:06, Gustavo Guillermo Pérez escribió:
> Hello list, I was trying to use a newer kernel on a gentoo installation,
> and I've downloaded a lastest kernel 2.6.17/16 getting a hardlock on boot
> time, with or without smp mode, controlled by BIOS or by smp kernel option
> I got 1 penguin or 2 penguins as processors get detected, it just hang
> after frame buffer or agp detection, but using vga=0 to not see any frame
> buffer I got a so faster oops and kernel panic and machine reboots, then I
> can't see anything on the screen, just with frame buffer enabled, but with
> frame buffer enabled does not work SySREQ, is just a hang.
>
> Attached .config file used, cat /proc/cpuinfo with 2.6.11 that was the
> kernel that can be built for, and lspci, and verbose lspci.
>
> The config file is the same used for the tests, with or without frame
> buffer enabled is the same.
>
> BIOS VERSION NT94510J.15A.0065.2005.1103.1803
>
> I'll going to upgrade the bios.
>
> Processor type: Intel (R) Pentium(R) D CPU 2.80GHz
> Intel (R) EM64T Capable.
>
> Using 512MB of DDR2 Dual Channel,
> ASL0 256MB
> ASL1 Not Installed
> BSL0 256MB
> BSL1 Not Installed

-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
