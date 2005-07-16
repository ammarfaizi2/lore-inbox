Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVGPJjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVGPJjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 05:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVGPJjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 05:39:10 -0400
Received: from ribosome.natur.cuni.cz ([195.113.57.20]:18627 "EHLO
	ribosome.natur.cuni.cz") by vger.kernel.org with ESMTP
	id S261323AbVGPJjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 05:39:09 -0400
Date: Sat, 16 Jul 2005 11:37:36 +0200
From: Martin Mokrejs <mmokrejs@ribosome.natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: init 0 stopped working
Message-ID: <20050716093736.GA13369@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I used to shutdown my P4 machine based on ASUS P4C800E-Deluxe
> with simple "init 0" command. That somehow broke between 2.6.12-rc6-git2
> and 2.6.13-rc1. The machines makes the sound like shutdown but it
> immediately turns the power on again. I used acpi and the kernel
> configs should be almost identical in all cases, as I just recopy
> previously used .config and run "make oldconfig".
> 
>   Any clues? I still happens even with 2.6.13-rc3-git2.

It was introduced after 2.6.12 but before or with 2.6.13-rc1.
It is not fixed by acpi-20050708 patch for 2.6.13 series.
I had KEXEC enabled and also disabled, but the problem still persists.
