Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUAOT6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbUAOT6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:58:14 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:29097 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S262564AbUAOT6J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:58:09 -0500
Date: Thu, 15 Jan 2004 21:57:58 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Something corrupts raid5 disks slightly during reboot
Message-ID: <20040115195758.GY11115822@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Samium Gromoff <deepfire@sic-elvis.zel.ru>,
	linux-kernel@vger.kernel.org
References: <877jzuxz5i.wl@canopus.ns.zel.ru> <20040114223040.GV11115822@niksula.cs.hut.fi> <87smihxu0u.wl@canopus.ns.zel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87smihxu0u.wl@canopus.ns.zel.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 03:42:41PM +0300, you [Samium Gromoff] wrote:
> At Thu, 15 Jan 2004 00:30:40 +0200,
> Ville Herva wrote:
> > 
> > On Wed, Jan 14, 2004 at 07:39:37PM +0300, you [Samium Gromoff] wrote:
> > > 
> > > I know this sounds stupid, but anyway:
> > > 
> > > I have seen the very same symptome caused by RAM faults (too slow ram
> > > for given clocks, to be exact).
> > 
> > The very same? You mean if booted, wrote few kB's of data to disk, synced,
> > then pressed reset, the same three bytes were corrupted (set to zero) each
> > time after reboot? 
> 
> No, corruption after reboot and perfect work inbetween.

Very strange. And you got rid of it by replacing the memory? 

Any theories on how faulty memory could actually cause something like this?
A bad spot in memory on an area where the bios code is cached, and hence is
never used apart from running the bios startup (not even by memtest86)?


-- v --

v@iki.fi
