Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbUAHNOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 08:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbUAHNOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 08:14:08 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:17280 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S264459AbUAHNOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 08:14:06 -0500
Date: Thu, 8 Jan 2004 14:14:04 +0100
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: won't work: 2.6.0 && SiI 3112 SATA
Message-ID: <20040108141404.B1041@beton.cybernet.src>
References: <20040106135634.A5825@beton.cybernet.src> <20040106132533.GD17606@carfax.org.uk> <20040106174714.B6567@beton.cybernet.src> <1866.208.180.249.106.1073426691.squirrel@mail.clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1866.208.180.249.106.1073426691.squirrel@mail.clanhk.org>; from heretic@clanhk.org on Tue, Jan 06, 2004 at 04:04:51PM -0600
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 04:04:51PM -0600, J. Ryan Earl wrote:
> > Any clue what can be wrong here?
> 
> Did you try what I suggested yet?  The crux of the problem is that here is
> that you're using an earlier version of the driver that doesn't contain my
> fix to how the controller gets programmed.
> 
> Copy the files at http://files.clanhk.org/siimage/ into drivers/ide/pci
> and recompile.

Yes, tried but it won't compile.

Then managed to enable the SCSI driver in promp for incomplete and/or
development drivers, applied the patch from don't know who that reenables
the interrupts and recognizes Adaptec 1210SA and it seems to work fine now.

Cl<
> 
> -ryan
