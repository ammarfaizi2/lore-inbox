Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbTA2HzA>; Wed, 29 Jan 2003 02:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbTA2HzA>; Wed, 29 Jan 2003 02:55:00 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:4992 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S265134AbTA2Hy7>;
	Wed, 29 Jan 2003 02:54:59 -0500
Date: Wed, 29 Jan 2003 00:04:20 -0800
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Anuradha Ratnaweera <ARatnaweera@virtusa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where are the matroxfb updates?
Message-ID: <20030129080420.GB4950@vana.vc.cvut.cz>
References: <20030129020639.GA10213@aratnaweera.virtusa.com> <20030129053159.GA5999@platan.vc.cvut.cz> <20030129073629.GA26091@aratnaweera.virtusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129073629.GA26091@aratnaweera.virtusa.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 01:36:29PM +0600, Anuradha Ratnaweera wrote:
> On Wed, Jan 29, 2003 at 06:31:59AM +0100, Petr Vandrovec wrote:
> > 
> > Though I'm not sure why you just do not upgrade to 2.4.21-pre4.
> 
> -pre3 and -pre4 don't build matroxfb_g450 and matroxfb_crtc2 as modules.
> I have FB_MATROX_G450 set to "m", so these modules don't get added to
> obj-m.  The "ifeq"s in the Makefile now check only for the value "y" of
> this symbol, not for "m".

You did not run 'make oldconfig', did you? G450 cannot be set to module
anymore, either you build core with gX50 support, or without. By default
people use secondary output on g550 and they were complaining that they see
nothing. So you do not have choice to screw up things now.
								Petr

