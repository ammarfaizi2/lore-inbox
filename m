Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266906AbRGYKlT>; Wed, 25 Jul 2001 06:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbRGYKk7>; Wed, 25 Jul 2001 06:40:59 -0400
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:23278 "HELO
	duron.intern.kubla.de") by vger.kernel.org with SMTP
	id <S266884AbRGYKkr>; Wed, 25 Jul 2001 06:40:47 -0400
Date: Wed, 25 Jul 2001 12:40:48 +0200
From: Dominik Kubla <kubla@sciobyte.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Jakma <paul@clubi.ie>, Dominik Kubla <kubla@sciobyte.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Arp problem
Message-ID: <20010725124048.A9264@intern.kubla.de>
In-Reply-To: <E15PBLE-00012l-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15PBLE-00012l-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, Jul 25, 2001 at 12:11:52AM +0100, Alan Cox wrote:
> > however, in the interests of flexibility and kindness to admins who
> > have to deal with legacy setups, is or would it be possible to make
> > linux be able to fully route packets between interfaces bound to the
> > same device?
> 
> Turn on ip forwarding, turn off ip redirect sending. It can all be done
> via /proc.

But that turns off all ip redirect sending, which may pose different
problems.  Kind of sledgehammer approach wouldn't you agree?  If somebody
were to produce a patch that allowed full routing between aliased interfaces
without turning off ip redirect sending, would you accept this?

Dominik
-- 
ScioByte GmbH, Zum Schiersteiner Grund 2, 55127 Mainz (Germany)
Phone: +49 6131 550 117  Fax: +49 6131 610 99 16

GnuPG: 717F16BB / A384 F5F1 F566 5716 5485  27EF 3B00 C007 717F 16BB
