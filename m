Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280150AbRJaLJz>; Wed, 31 Oct 2001 06:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280152AbRJaLJq>; Wed, 31 Oct 2001 06:09:46 -0500
Received: from gaston.ina.fr ([194.3.210.66]:42185 "HELO gaston.ina.fr")
	by vger.kernel.org with SMTP id <S280150AbRJaLJb>;
	Wed, 31 Oct 2001 06:09:31 -0500
Message-ID: <001101c161fc$96e61b00$222502c2@marmotte2000>
From: "Matthieu Fleurmont" <mfleurmont@ina.fr>
To: "Mark Hahn" <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10110301851430.10893-100000@coffee.psychology.mcmaster.ca>
Subject: Re: debugging tools under 2.2.18 with RTL 3.0 pre10 patch
Date: Wed, 31 Oct 2001 12:10:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where are not handling IO from user space but we are synchronizing those
materials with a kind of automation...
And all our tasks ( video capture and analysis, commands and data from and
to VTR and Video server, GUI refresh and more ) should be done within 20 ms,
that is why we needed and installed RTL.

I should have precised that obviously all of our code is not in the kernel.

And not to be insulting : what an useful answer U made ... ;op
However thank you for having began this thread...

Best regards
Matthieu
----- Original Message -----
From: "Mark Hahn" <hahn@physics.mcmaster.ca>
To: "Matthieu Fleurmont" <mfleurmont@ina.fr>
Sent: Wednesday, October 31, 2001 12:52 AM
Subject: Re: debugging tools under 2.2.18 with RTL 3.0 pre10 patch


> > We are developping a few kernel modules handling serial ports in order
to have a
> > real time control on professional video systems as VTR, video servers
and more
> > ...
>
> realtime IO from user-space is not hard.
>
> > I am looking for a way that would allow me to have a kind of core dump
instead
> > of of freezing and rebooting my box when my code is wrong and the module
not
> > working properly...
> >
> > Thanks to any one who already solved this problem and would share its
experience
> > with me.
>
> not to be insulting, but crashing is exactly why any code that
> doesn't absolutely have to be in the kernel, shouldn't be in the kernel...
>

