Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267847AbTBRPzk>; Tue, 18 Feb 2003 10:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267858AbTBRPzk>; Tue, 18 Feb 2003 10:55:40 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:4625 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267847AbTBRPzD>; Tue, 18 Feb 2003 10:55:03 -0500
Date: Tue, 18 Feb 2003 16:05:04 +0000
From: John Levon <levon@movementarian.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: module changes
Message-ID: <20030218160504.GA97537@compsoc.man.ac.uk>
References: <20030217213221.3103.qmail@eklektix.com> <20030218072006.4C6502C054@lists.samba.org> <15954.22427.557293.353363@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15954.22427.557293.353363@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18lAEy-000Ene-00*NZ56hmN8HTU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 04:56:11PM +0100, Mikael Pettersson wrote:

> Does the implementation have to be perfect? The per_cpu API can easily
> be simulated using good old NR_CPUS arrays:

I agree, the main advantage of having per-cpu API available to modules
is that code can just use it and not worry about module vs. monolithic.
Some obscure limitation doesn't sound like a good idea in that respect
:)

regards
john
