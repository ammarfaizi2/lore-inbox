Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318810AbSG0TlY>; Sat, 27 Jul 2002 15:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318813AbSG0TlY>; Sat, 27 Jul 2002 15:41:24 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:59188 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S318810AbSG0TlX>; Sat, 27 Jul 2002 15:41:23 -0400
Date: Sat, 27 Jul 2002 22:44:29 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Speaker twiddling [was: Re: Panicking in morse code]
Message-ID: <20020727194429.GR1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org
References: <3D4298C6.9080103@sktc.net> <200207271856.g6RIufn63592@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207271856.g6RIufn63592@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 02:56:41PM -0400, you [Albert D. Cahalan] wrote:
> Reality?
> 
> There's no "set up a microphone and decoder" problem.
> Most people have a tape recorder. Use that, then play
> back into the PC's sound card after you reboot. Post the
> sound file on a web site.

Reality?

I don't have a tape recorder, and even if I had that procedure is so tedious
that I'd rather write the oops down with a pen. And I don't use pen
willingly as it is error prone. (I don't even dare to think what Windows
people would say if I actually found a magnetophone and a mic and tried to
sneak into the curiously twittering server room without anyone noticing.)

Let's get real. There's much better solutions already available: 
 - serial console that has been in kernel for ages
   (sneaking into server room with an old laptop and serial cable
   at least _looks_ professional)
 - kmsgdump from Willy Tarreau that writes the oops to a floppy (even makes
   a msdos fs), can use printer and enables pgup/pgdown even after lockup so
   that you can see the whole kernel ring buffer (who would ever notice if
   you sneak out from the server room with a floppy or a sheet of paper)
   http://wtarreau.free.fr/kmsgdump/
 - netconsole from Ingo Molnar that logs the oops over udp (you don't even
   have to sneak into the server room)
   http://people.redhat.com/mingo/netconsole-patches/

Now, I would assume that most people have a floppy, printer or a network
connection. At least more people than have a tape recorder.


-- v --

v@iki.fi
