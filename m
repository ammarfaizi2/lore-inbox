Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbSLOMSN>; Sun, 15 Dec 2002 07:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbSLOMSN>; Sun, 15 Dec 2002 07:18:13 -0500
Received: from 3eea160b.cable.wanadoo.nl ([62.234.22.11]:16261 "EHLO
	asterix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S266453AbSLOMSM>; Sun, 15 Dec 2002 07:18:12 -0500
Date: Sun, 15 Dec 2002 13:25:54 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 load avg += 1
Message-ID: <20021215132554.D3779@bitwizard.nl>
References: <Pine.LNX.4.44.0212141357550.9240-100000@coffee.psychology.mcmaster.ca> <200212151202.09618.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212151202.09618.roy@karlsbakk.net>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 12:02:09PM +0100, Roy Sigurd Karlsbakk wrote:
> On Saturday 14 December 2002 19:58, Mark Hahn wrote:
> > > running 2.5.51, when I run 'uptime', it shows my uptime+1. that means if
> > > my
> >
> > might you have a process/thread stuck in a short wait?
> 
> how can this be? the load average was at the given point excactly 1.0, but the 
> number of running processes (ps ax|grep -v grep | grep -w R) was 0.

Processes in "D" state also count towards the load average. Because
usually that means a "disk wait" which usually impacts 
subjective-performance of the system just as much as the "running" 
processes do. 

				Roger. 
