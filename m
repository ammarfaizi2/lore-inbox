Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbUDNMkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 08:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUDNMkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 08:40:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:25995 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264174AbUDNMkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 08:40:37 -0400
X-Authenticated: #11437207
Date: Wed, 14 Apr 2004 15:41:42 +0200
From: Tim Blechmann <TimBlechmann@gmx.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Ivica Ico Bukvic <ico@fuse.net>,
       "'Thomas Charbonnel'" <thomas@undata.org>, ccheney@debian.org,
       linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion
 -- FIXED!
Message-Id: <20040414154142.5bfe3460@laptop>
In-Reply-To: <20040412163854.C12980@flint.arm.linux.org.uk>
References: <20040412082801.A3972@flint.arm.linux.org.uk>
	<20040412144103.PIXB8029.smtp1.fuse.net@64BitBadass>
	<20040412155336.B12980@flint.arm.linux.org.uk>
	<200404121731.20765.daniel.ritz@gmx.ch>
	<20040412163854.C12980@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi russell and others ...

i'm curious, since our discussion got quiet in the last few days ... if
ico was able to solve his problem by altering cardbus registers, but my
hdsp works fine with windows with the same register settings on the
cardbus bridge that won't work with linux ... what does this imply to my
setup? do you have any idea, where could be the problem?

my system doesn't have the pci bus connected directly to the cardbus
bridge, but there is a pci-to-pci bridge in between ... i found a
register difference between the windows and the linux settings in that
... but changing this register doesn't change the behaviour of the hdsp
:-(

cheers...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac

