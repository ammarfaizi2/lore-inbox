Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287249AbSACNBL>; Thu, 3 Jan 2002 08:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287251AbSACNBC>; Thu, 3 Jan 2002 08:01:02 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:44040 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S287249AbSACNAs>; Thu, 3 Jan 2002 08:00:48 -0500
Message-Id: <200201031300.g03D0cwF021145@pincoya.inf.utfsm.cl>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Wed, 02 Jan 2002 16:47:57 CDT." <20020102164757.A16976@thyrsus.com> 
Date: Thu, 03 Jan 2002 10:00:38 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:

[...]

> But only for people and programs with root privileges.  It all turns
> then, on whether we want to insist that all software doing hardware 
> probing must have root privileges to function.

So bind it to a capability.

> I submit that the answer is "no" -- the right direction, for security
> and other reasons, is to make *fewer* capabilities dependent on root
> privileges rather than more, and to reject design approaches that
> imply creating more suid programs to give ordinary users capabilities
> that involve only *reading* config information.

Then create /etc/dmi or /var/log/dmi on boot from an initscript. /proc is a
nice idea for _process_ information, the other junk in there should go away
IMVHO. Hard to do as it is now customary. Adding more junk is (a) kernel
bloat, (b) hard to clean up later.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
