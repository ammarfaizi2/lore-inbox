Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSHXPyw>; Sat, 24 Aug 2002 11:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSHXPyw>; Sat, 24 Aug 2002 11:54:52 -0400
Received: from velli.mail.jippii.net ([195.197.172.114]:23495 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S314529AbSHXPyv>; Sat, 24 Aug 2002 11:54:51 -0400
Date: Sat, 24 Aug 2002 19:03:06 +0300
From: Anssi Saari <as@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
Message-ID: <20020824160306.GA6827@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	linux-kernel@vger.kernel.org
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com> <20020823163056.GA7426@sci.fi> <8765y1a50b.fsf@plailis.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8765y1a50b.fsf@plailis.homelinux.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 06:56:04PM +0200, Markus Plail wrote:
> * Anssi Saari writes:
 
> If you burn data in DAO mode you will have the same behaviour.

No I don't. I saw the discussion about that recently, but I don't have
that problem.

> Have you
> tried to toggle CONFIG_IDEPCI_SHARE_IRQ? It helped me a lot. Also I
> have to disable umaskirq, otherwise I have the same problems.

I'll have to see if that helps, thanks for the tip.

> One thing I still do not understand is:
> IS DMA (theoretically) possible for stuff like c2scans, DAO writing,
> audio grabbing? 

I don't know of the other stuff, but since there's a patch for Linux
which does audio grabbing with DMA, I'd assume it's possible.

Then again, is DMA that important for these fairly slow devices? PDC20265
and CMD649 don't seem to support DMA with ATAPI devices (in Linux
at least), but I have none of these performance problems with those
contollers, only the VIA 686b.
