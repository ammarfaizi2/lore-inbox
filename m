Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSLQPlZ>; Tue, 17 Dec 2002 10:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSLQPlZ>; Tue, 17 Dec 2002 10:41:25 -0500
Received: from 24.213.60.109.up.mi.chartermi.net ([24.213.60.109]:26241 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id <S261451AbSLQPlY>; Tue, 17 Dec 2002 10:41:24 -0500
Date: Tue, 17 Dec 2002 10:49:27 -0500 (EST)
From: Nathaniel Russell <reddog83@chartermi.net>
X-X-Sender: reddog83@reddog.example.net
To: alan@lxorguk.ukuu.org.uk
cc: alan@redhat.com, <reddog83@chartermi.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Via 8233 flooding of errors [2.4-ac]
In-Reply-To: <Pine.LNX.4.44.0212171033071.1576-100000@reddog.example.net>
Message-ID: <Pine.LNX.4.44.0212171035450.1629-100000@reddog.example.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
What would you like to me to send you all i play are mp3's and i watch DVD's???
And about the ignoring drained playback i can just ignore that paranoia, that
is fine with me. Oh and yes i hit ^C to stop the mp3 player :).

CC me <reddog83@chartermi.net>
On 17 Dec 2002, Alan Cox wrote:

> On Tue, 2002-12-17 at 11:41, Nathaniel Russell wrote:
> > Hello
> > When i play 3 or more songs in a row i get the error message of
> > drained playback and my audio just shuts off until i exit the mp3 program
> > and reload it. Every 3rd song though it stops playing. And plus once in
> > awhile i get a Assertion failed message. Help please....
> > Nathaniel
>
> > Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1347
> > via_audio: ignoring drain playback error -512
> > [SNIPED]
>
> I need to look at the assertion - somehow the chip is being stopped when
> it should not have been. The ignoring drain playback error one is over
> paranoia in the driver and quite legal (you hit ^C is what made that
> second moan appear)
>




