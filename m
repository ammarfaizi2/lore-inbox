Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVCLE6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVCLE6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 23:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVCLE6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 23:58:41 -0500
Received: from thunk.org ([69.25.196.29]:48860 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261862AbVCLE6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 23:58:37 -0500
Date: Fri, 11 Mar 2005 23:58:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Moritz Muehlenhoff <jmm@inutil.org>,
       Martin Josefsson <gandalf@wlug.westbo.se>,
       Volker Braun <volker.braun@physik.hu-berlin.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Average power consumption in S3?
Message-ID: <20050312045828.GA19215@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Moritz Muehlenhoff <jmm@inutil.org>,
	Martin Josefsson <gandalf@wlug.westbo.se>,
	Volker Braun <volker.braun@physik.hu-berlin.de>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20050309142612.GA6049@informatik.uni-bremen.de> <1110388970.1076.48.camel@tux.rsn.bth.se> <20050310180826.GA6795@informatik.uni-bremen.de> <20050311034615.GA314@thunk.org> <1110516679.32557.350.camel@gaston> <20050311174433.GA6735@thunk.org> <1110584902.5809.116.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110584902.5809.116.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 10:48:21AM +1100, Benjamin Herrenschmidt wrote:
> 
> I'm hesitant to switch a whitelist because of a couple of settings in
> there that are specific to the way the chip is wired on the mobo.
> Apparently, thinkpads are similar enough to Macs, but I wouldn't bet on
> this beeing "commmon"...

If this is true, then ATI probably won't be able to tell us anything
useful, so we're only going to find out if people in the Thinkpad
division are willing to tell us something useful (and their track
record for being helpful has not been particularly stellar).

And what I was thinking about doing was having the CONFIG option only
do it for machines that were detected as being IBM Thinkpads, not all
Radeon chips.  The blacklist would be for specific IBM thinkpad
models; what I'm guessing here is that it's likely that all or most
modern IBM thinkpads are going to be wired the same way on the
motherboard.  

						- Ted
