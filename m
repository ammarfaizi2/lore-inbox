Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277243AbRJDV7f>; Thu, 4 Oct 2001 17:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277244AbRJDV7Z>; Thu, 4 Oct 2001 17:59:25 -0400
Received: from ppp-RAS1-6-146.dialup.eol.ca ([64.56.229.146]:40970 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S277243AbRJDV7G>; Thu, 4 Oct 2001 17:59:06 -0400
Date: Thu, 4 Oct 2001 17:57:39 -0400
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: CPU Temperature?
Message-ID: <20011004175739.A1761@node0.opengeometry.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E15pFns-0004DA-00@the-village.bc.nu> <Pine.LNX.4.30.0110041442430.3919-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0110041442430.3919-100000@anime.net>; from goemon@anime.net on Thu, Oct 04, 2001 at 02:43:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 02:43:24PM -0700, Dan Hollis wrote:
> > > How can I access the CPU temperature, fan speed etc. from Linux?
> > > Or is this too hardware dependent to implement a common interface?
>
> > lm-sensors - it works well. Its shipped in some vendor trees
> 
> Whats the schedule to merge with mainline kernel? Right now we have
> two i2c trees -- the one in the kernel and the one in lm-sensors...

On my Abit VP6, hardware monitoring is on IO address 0x294h to 0x297h.
Why do we have to patch kernel and load module?  Isn't there something
simpler which we can compile and run as root?

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
8 CPU cluster, Linux (Slackware), Python, LaTeX, Vim, Mutt, Tin
