Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWDYNAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWDYNAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 09:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWDYNAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 09:00:38 -0400
Received: from witte.sonytel.be ([80.88.33.193]:64176 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932212AbWDYNAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 09:00:37 -0400
Date: Tue, 25 Apr 2006 15:00:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Nix <nix@esperi.org.uk>,
       "Makan Pourzandi (QB/EMC)" <makan.pourzandi@ericsson.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication
 of binaries
In-Reply-To: <1145946650.3114.13.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.62.0604251459410.10839@pademelon.sonytel.be>
References: <6D19CA8D71C89C43A057926FE0D4ADAA29D361@ecamlmw720.eamcs.ericsson.se>
 <1145897277.3116.44.camel@laptopd505.fenrus.org> <87hd4ipvdk.fsf@hades.wkstn.nix>
 <1145911526.3116.71.camel@laptopd505.fenrus.org> <87zmiao8bq.fsf@hades.wkstn.nix>
 <1145946650.3114.13.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006, Arjan van de Ven wrote:
> On Tue, 2006-04-25 at 00:35 +0100, Nix wrote:
> > On Mon, 24 Apr 2006, Arjan van de Ven yowled:
> > > On Mon, 2006-04-24 at 21:32 +0100, Nix wrote:
> > >> It checks mmap and mprotect with PROT_EXEC, and execve().
> > > 
> > > so no jvm's or flash plugins.
> > 
> > Well, you'll have to sign the flash plugin. This isn't
> > sign-at-compilation-time; 
> 
> the point I made is that a jvm has executable memory capabilities (it
> has to) and can be made an elf loader. At which point.. game over.

Then don't sign the jvm ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
