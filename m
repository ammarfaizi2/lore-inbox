Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbTK3Pqy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 10:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbTK3Pqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 10:46:54 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:18 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264923AbTK3Pqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 10:46:53 -0500
Date: Sun, 30 Nov 2003 16:46:41 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andrew Clausen <clausen@gnu.org>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031130154641.GB5763@win.tue.nl>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <20031129222722.GA505@gnu.org> <20031130003428.GA5465@win.tue.nl> <Pine.LNX.4.58.0311301210540.2329@ua178d119.elisa.omakaista.fi> <20031130132649.GC5738@win.tue.nl> <Pine.LNX.4.58.0311301403130.2329@ua178d119.elisa.omakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311301403130.2329@ua178d119.elisa.omakaista.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 02:34:23PM +0200, Szakacsits Szabolcs wrote:

> > if there is a partition table already and we are able to guess a geometry 
> > from that, use that; otherwise [...]
> 
> OK, thanks, the problem is here. Maybe a warning could be added

The docs and the programs are full of warnings already.
Too many in fact. People worry and get nervous, needlessly.
In a very small percentage of cases there really are problems,
but again these warnings "there might be problems" are not very helpful.


 The number of cylinders for this disk is set to 70780.
 There is nothing wrong with that, but this is larger than 1024,
 and could in certain setups cause problems with:
 1) software that runs at boot time (e.g., old versions of LILO)
 2) booting and partitioning software from other OSs
    (e.g., DOS FDISK, OS/2 FDISK)


Does this help anybody?

