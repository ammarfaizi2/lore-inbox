Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312791AbSDKU2z>; Thu, 11 Apr 2002 16:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312915AbSDKU2y>; Thu, 11 Apr 2002 16:28:54 -0400
Received: from server1.symplicity.com ([209.61.154.230]:39952 "HELO
	mail2.symplicity.com") by vger.kernel.org with SMTP
	id <S312791AbSDKU2u>; Thu, 11 Apr 2002 16:28:50 -0400
From: "Alok K. Dhir" <adhir@symplicity.com>
To: "'Stijn Verrept'" <sverrept@vub.ac.be>, <linux-kernel@vger.kernel.org>
Subject: RE: KVM Switch bug
Date: Thu, 11 Apr 2002 16:26:03 -0400
Message-ID: <003201c1e197$1a5c1c40$6501a8c0@frodo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <200204112050.37043.sverrept@vub.ac.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is most likely a function of your KVM switch.  I used to use a
Logitech two way KVM which worked fine switching back and forth, except
Linux never saw the mouse wheel, and occassionally I'd lose keyboard
(both in Windows and Linux) which typically required unplugging and
replugging the keyboard.  The Logitech also had the insanely stupid
design of using the ctrl key for switching.  Finally, it adversely
affected my key repeat rate (which drove me crazy).

I now use a Linkskey KVM-K104M ($64.00 at newegg.com) - a four way which
costs less than the 2-way logitech, in which everything works without a
hitch, including the mouse wheel, in both Windows and Linux.  EXCEPT -
in Linux, the wheel doesn't work after I switch away from it and back.
Resetting the X display by switching to a console terminal (ALT-CTRL-Fn)
and back fixes it however.  It also uses a much more sensible key for
switching (double click scroll lock followed by a number (1-4)).  AND -
as a bonus, my key repeat is back up to my desired rate.

I've heard of people having all kinds of problems - the problems are
almost always a function what KVM they're using.

I cannot recommend the Linkskey highly enough.

Alok

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Stijn Verrept
> Sent: Thursday, April 11, 2002 2:51 PM
> To: linux-kernel@vger.kernel.org
> Subject: KVM Switch bug
> 
> 
> Hi,
> 
> When switching using a KVM switch I loose keyboard (only in 
> Linux so it's not 
> hardware related)
> 
> I'm using a ADDERView KVM switch (used to connect multiple 
> PC's to one key / 
> mouse / screen).  After looking on the internet I have found 
> lots of other 
> users having the same problem, with other KVM switches.
> This happens both in console as in X.  Keyboard and mouse I 
> use are both PS/2.
> 
> Using Linux version: 2.4.18-6mdk (gcc version 2.96 20000731)
> 
> I think anything else is pretty irrelavant.
> 
> Kind regards,
> 
> Stijn Verrept.
> 
> BTW Can I get any feedback on this?
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

