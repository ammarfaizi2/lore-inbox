Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132526AbRDUVJm>; Sat, 21 Apr 2001 17:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132561AbRDUVJW>; Sat, 21 Apr 2001 17:09:22 -0400
Received: from huizehofstee.xs4all.nl ([194.109.241.183]:54797 "EHLO
	server.hofstee") by vger.kernel.org with ESMTP id <S132526AbRDUVJR>;
	Sat, 21 Apr 2001 17:09:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Victor Julien <v.p.p.julien@let.rug.nl>
Organization: Huize Hofstee
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3+ sound distortion
Date: Sat, 21 Apr 2001 23:07:23 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.05.10104211159030.5218-100000@cosmic.nrg.org> <01042121403000.00436@victor> <20010421225205.B2615@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010421225205.B2615@arthur.ubicom.tudelft.nl>
MIME-Version: 1.0
Message-Id: <01042123072300.00453@victor>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't use APM monitors. The noise is more frequent than once every few 
seconds. I've tried to reproduce the noise using cpu-intensive programs other 
than seti@home and i failed. I tried compiling a kernel together with heavy 
calculations in The Gimp, but it didn't produce the noise. Could it be a 
problem only triggerd by seti? Is there something special about seti?


Victor Julien


Please enter my email-adress in the CC.


> On Sat, Apr 21, 2001 at 09:40:30PM +0200, Victor Julien wrote:
> > That did not help. The distortion is no stuttering, but noise in the
> > music. It's not specific to xmms, freeamp and xine also have the noise.
> > The noise reminds me of years ago when my father used a electric shaver
> > witch gave noise in the sound of my radio. Maybe that can give you an
> > idea about the sort of noise.
> >
> > The changelog of 2.4.3 said that there were via-chipset-fixes undone,
> > could this be a problem of my chipset?
>
> Possible. Another thing to check is if you started using an APM
> monitoring program, like the GNOME battery_applet which reads /proc/apm
> every couple of seconds. With every read of /proc/apm the APM driver
> calls the APM BIOS, which on some systems runs quite long with
> interrupts disabled. On my laptop this results in exactly the noise you
> described.
>
>
> Erik
