Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270069AbTGWLLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 07:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269978AbTGWLLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 07:11:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7809 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270069AbTGWLLt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 07:11:49 -0400
Date: Wed, 23 Jul 2003 07:28:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@suse.cz>
cc: textshell@neutronstar.dyndns.org, Dominik Brodowski <linux@brodo.de>,
       davej@suse.de, Linux kernel <linux-kernel@vger.kernel.org>,
       Henrik Persson <nix@syndicalist.net>
Subject: Re: 2.6.0-test1: CPUFreq not working, can't find sysfs interface
In-Reply-To: <20030723111320.GB729@zaurus.ucw.cz>
Message-ID: <Pine.LNX.4.53.0307230720190.8208@chaos>
References: <20030720150243.GJ2331@neutronstar.dyndns.org>
 <200307201745.h6KHjcHt095999@sirius.nix.badanka.com>
 <20030720211246.GK2331@neutronstar.dyndns.org> <20030722120811.GD1160@brodo.de>
 <20030722141839.GD7517@neutronstar.dyndns.org> <20030722142353.GA1301@brodo.de>
 <20030722145352.GE7517@neutronstar.dyndns.org> <20030723111320.GB729@zaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003, Pavel Machek wrote:
[SNIPPED...]

> 				Pavel
> Hardware that lets software kill it deserved that.

Don't touch the Motorola 56xxx DSP, then. There are several
"insane instructions" that will smoke the device (programming
a pin for both input and output at the same time). There are
many other chips, often used on Motherboards, that have
programmable pins (even the AMD SC520)... These can be destroyed
by software.

Also, the bits for setting the power supply voltages to be
applied to your CPU are available in I/O space on many motherboards.
Try your 2.5 volt CPU on 5.0 volts. It will melt the solder that
holds the socket to the board!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

