Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129963AbQJ0LQS>; Fri, 27 Oct 2000 07:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130135AbQJ0LQI>; Fri, 27 Oct 2000 07:16:08 -0400
Received: from styx.suse.cz ([195.70.145.226]:33778 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129963AbQJ0LPx>;
	Fri, 27 Oct 2000 07:15:53 -0400
Date: Fri, 27 Oct 2000 13:15:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Cc: Martin Mares <mj@suse.cz>, "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
Message-ID: <20001027131548.A651@suse.cz>
In-Reply-To: <m3d7gnd31m.fsf@test1.mandrakesoft.com> <Pine.LNX.3.95.1001026115039.12337A-100000@chaos.analogic.com> <20001026190309.A372@suse.cz> <20001027120220.A5741@atrey.karlin.mff.cuni.cz> <20001027124947.A476@suse.cz> <m38zrablff.fsf@test1.mandrakesoft.com> <20001027130151.A607@suse.cz> <m3y9zaa60d.fsf@test1.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3y9zaa60d.fsf@test1.mandrakesoft.com>; from yoann@mandrakesoft.com on Fri, Oct 27, 2000 at 01:16:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 01:16:34PM +0200, Yoann Vandoorselaere wrote:

> > Which part of the chipset you mean? The PIT (programmable interrupt
> > timer)? That one is standard since XT times. The rest of the ISA bridge?
> > Maybe, but that's mostly BIOS work and shouldn't impact the PIT
> > under sane conditions.
> 
> What is strange is that a number of persons seem to be hit by this
> problem... And if VIA didn't corrected it it's probably because
> they are not aware of it...
> 
> I think that if such problem occured under windows 
> (thinking to the windows user base), VIA would be already in touch.

It can't happen under Windows, because Windows timer runs at 18 Hz
(timer programmed to 65535), while Linux uses 100 Hz (timer programmed
to approx 11920), so when the timer unprograms itself due to the bug to
65535, only Linux notices it, Windows can't.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
