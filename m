Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285448AbRLSUMK>; Wed, 19 Dec 2001 15:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285450AbRLSUMA>; Wed, 19 Dec 2001 15:12:00 -0500
Received: from fepD.post.tele.dk ([195.41.46.149]:16374 "EHLO
	fepD.post.tele.dk") by vger.kernel.org with ESMTP
	id <S285448AbRLSUL5>; Wed, 19 Dec 2001 15:11:57 -0500
Message-ID: <001f01c18911$b2cfd9a0$0b00a8c0@runner>
From: "Rune Petersen" <rune.mail-list@mail.tele.dk>
To: "Eli" <eli@pflash.com>, <linux-kernel@vger.kernel.org>
Cc: <eli@pflash.com>, <arjanv@redhat.com>
In-Reply-To: <E16Glz1-0005mt-00@pintail.mail.pas.earthlink.net>
Subject: Re: 2.4.x WinBookXL mouse & keyboard freeze (and on Uniwill 340S2)
Date: Wed, 19 Dec 2001 20:49:24 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same Problem on My Uniwill 340S2, it uses a Synaptics touchpad
and I can unlock it by pressing the power-key.

There were some drivers (kernelpatch + config-utility) for the Synaptics
touch pad, but it havent been updated for some time:
http://compass.com/synaptics/

you might want to take a look.

Rune Petersen
----- Original Message -----
From: Eli <eli@pflash.com>
To: <linux-kernel@vger.kernel.org>
Cc: <eli@pflash.com>; <arjanv@redhat.com>
Sent: Wednesday, December 19, 2001 10:54 AM
Subject: Re: 2.4.x WinBookXL mouse & keyboard freeze


> On Wednesday 19 December 2001 12:33 pm, Eli wrote:
> > When running any 2.4.x kernel, if gpm is running, touching the mouse
ends
> > all keyboard input.  Starting X without touching the mouse does the same
> > thing. The mouse in this case is the built-in trackpad thing common in
> > notebooks. 2.2.x works just fine.
> >
> > I don't know quite where to start on this... I've tried changing gpm
> > configuration, but that doesn't seem to help.
> > (I'm running RedHat 7.2.)
> >
> > Any ideas on where I should start looking?
>
> Ok, I found discussion of this bug here:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=37812
>
> I'll start playing with some of the ideas listed, but I don't see a good
> conclusion on it.  What kind of a fix would be accepted into the mainline?
>
> TIA,
>
> Eli
> ---------------.
> Eli Carter      \
> eli(a)pflash.com `-------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


