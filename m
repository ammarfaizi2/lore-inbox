Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbTC1Ha0>; Fri, 28 Mar 2003 02:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbTC1Ha0>; Fri, 28 Mar 2003 02:30:26 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:39178 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262243AbTC1HaZ>;
	Fri, 28 Mar 2003 02:30:25 -0500
Date: Thu, 27 Mar 2003 23:40:31 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, sensors@stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030328074031.GA29404@kroah.com>
References: <1048806052.10675.4440.camel@cube> <20030327231027.GC1687@kroah.com> <1048836107.4776.2285.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048836107.4776.2285.camel@workshop.saharact.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 09:21:48AM +0200, Martin Schlemmer wrote:
> 
> Silly w83781d again.  temp1 is a u8, and temp2 and temp3 is u16
> (if they are supported on the specific model.
> 
> Should we do any bounds checking on input via sysfs ?

So that you can't hurt your hardware or crash the os, yes.

I think the write ability is limited to root, so that's a good first
step too.

thanks,

greg k-h
