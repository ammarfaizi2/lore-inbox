Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUANWbC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUANWbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:31:02 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:13759 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263228AbUANWa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:30:56 -0500
Date: Thu, 15 Jan 2004 00:30:40 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Something corrupts raid5 disks slightly during reboot
Message-ID: <20040114223040.GV11115822@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Samium Gromoff <deepfire@sic-elvis.zel.ru>,
	linux-kernel@vger.kernel.org
References: <877jzuxz5i.wl@canopus.ns.zel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877jzuxz5i.wl@canopus.ns.zel.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 07:39:37PM +0300, you [Samium Gromoff] wrote:
> 
> I know this sounds stupid, but anyway:
> 
> I have seen the very same symptome caused by RAM faults (too slow ram
> for given clocks, to be exact).

The very same? You mean if booted, wrote few kB's of data to disk, synced,
then pressed reset, the same three bytes were corrupted (set to zero) each
time after reboot? 

I can buy the faulty ram explanation for many symptoms, but it somehow in
this case it seems very unlikely. The box can be doing its thing (backing up
>20 workstations onto 6 ide disks) for weeks without ever corrupting
anything, and the when I power it down and up (after manually raidstopping
and umounting), three bytes get corrupted. (Well, sometimes few bytes in
addition to the three, but usually just three.)

> Yes gzipping/gunzipping a gigabyte of /dev/random data didn`t show up a
> crc error.

The box does survive memtest, but you're right that doesn't prove anything.
 
> That was an i845 chipset, by the way...

This is i815.


-- v --

v@iki.fi
