Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbUKDAo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbUKDAo4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUKDAlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:41:45 -0500
Received: from dsl017-059-236.wdc2.dsl.speakeasy.net ([69.17.59.236]:33984
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S261953AbUKDAgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:36:48 -0500
Date: Wed, 3 Nov 2004 19:43:42 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041104004342.GD5283@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200411030751.39578.gene.heskett@verizon.net> <200411031124.19179.gene.heskett@verizon.net> <20041103201322.GA10816@hh.idb.hist.no> <200411031540.03598.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411031540.03598.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.9
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 03:40:03PM -0500, Gene Heskett took 89 lines to write:
> On Wednesday 03 November 2004 15:13, Helge Hafting wrote:
> >
> >Yes it does - the problem is that not all resources are managed
> >by processes.  Some allocations are managed by drivers, so a driver
> >bug can get the device into a unuseable state _and_ tie up the
> >process(es) that were using the driver at the moment.
> 
> This from my viewpoint, is wrong.  The kernel, and only the kernel 
> should be ultimately responsible for handing out resources, and 
> reclaiming at its convienience.

This might just be semantics, but device drivers are part of the kernel.

Kurt
-- 
In 1750 Issac Newton became discouraged when he fell up a flight of
stairs.
