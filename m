Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264734AbRFQOFL>; Sun, 17 Jun 2001 10:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264735AbRFQOE7>; Sun, 17 Jun 2001 10:04:59 -0400
Received: from www.transvirtual.com ([206.14.214.140]:18444 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S264734AbRFQOEp>; Sun, 17 Jun 2001 10:04:45 -0400
Date: Sun, 17 Jun 2001 07:03:55 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: =?X-UNKNOWN?Q?Ren=E9_Rebe?= <rene.rebe@gmx.net>
cc: linux-kernel@vger.kernel.org, ademar@conectiva.com.br, rolf@sir-wum.de,
        linux-fbdev-devel@lists.sourceforge.net
Subject: Re: sis630 - help needed debugging in the kernel
In-Reply-To: <20010616232740.092475e2.rene.rebe@gmx.net>
Message-ID: <Pine.LNX.4.10.10106170652280.17509-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > I currently try to debug why the sisfb driver crashes my machine. (SIS 630
> > > > based laptop - linux-2.4.5-ac13).
> > > 
> > > You can do one of two things. Post both System.map and the complete oops
> > > or you can run ksymoops on the oops. I can find the problem then. Thanks.
> > 
> > ksymoops' output is attached.
> 
> Is there any result with this trace??

Yes. It oops in fbcon_cfb8_putc. I haven't figured out yet what exactly
caused it. I don't have this card to play with :-( Did you run the other
test I suggested. Try booting at 640x480 with a color depth of 32. Then
try booting at a different resolution (1024x768) at the default color
depth. I want to see if its a error with the resolution setting or if it
is a error with setting up the data relating to the color depth handling. 
The results should give me some clue.

