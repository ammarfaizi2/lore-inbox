Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131082AbQLMLp0>; Wed, 13 Dec 2000 06:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbQLMLpQ>; Wed, 13 Dec 2000 06:45:16 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:37906 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131082AbQLMLpI> convert rfc822-to-8bit; Wed, 13 Dec 2000 06:45:08 -0500
Date: Wed, 13 Dec 2000 12:13:49 +0100
From: Martin Macok <martin.macok@underground.cz>
To: Petr Sebor <petr@scssoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12 randomly hangs up
Message-ID: <20001213121349.A6787@sarah.kolej.mff.cuni.cz>
In-Reply-To: <20001213105153.A6624@sarah.kolej.mff.cuni.cz> <000f01c064f4$157f3570$a49418d4@shredder>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <000f01c064f4$157f3570$a49418d4@shredder>; from petr@scssoft.com on Wed, Dec 13, 2000 at 12:01:46PM +0100
X-Echelon: GRU NSA GCHQ KGB CIA nuclear conspiration war weapon spy agent
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 12:01:46PM +0100, Petr Sebor wrote:
> From: "Martin Macok" <martin.macok@underground.cz>
> > after 1-3 hours with -test12 system hangs up with
> >  - no response from mouse
> >  - no response from keyboard (no sysrq, only sysrq+'b' works ...)
> >  - no response from network (ICMP, TCP)
> >  - nothing on console, nothing in logs (ie. nothing interesting or relevant
> >    to crash).
> > 
> > System was not under load (1 user, X, no swapping ...)
>
> Same here... this thing started to happen right after upgrading to test12 
> (from test11). I am still being able to work on console for hours but when 
> I start using X the system dies silently. No oops, keyboard inactive 
> (can't do sysrq), and the LED on the monitor is orange, not green. This 
> happens under almost no load at all even after a fresh start. I have plenty
> of free memory, swap file not used at all.
> 
> Just a 'me too'

I can (re)confirm that. I work several hours on console without any
problem ... then I start X session and after several minutes system
hangs.

Red Hat 7.0, XFree-3.3.6 (SVGA server), S3Virge/G2 (4MB)

(no problems with -test11 and 2.2.x before ...)

Have a nice day

(P.S. Thanks for Cc:'ing me ...)

-- 
   Martin Maèok
  underground.cz
    openbsd.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
