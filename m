Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275874AbSIUDw3>; Fri, 20 Sep 2002 23:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275875AbSIUDw2>; Fri, 20 Sep 2002 23:52:28 -0400
Received: from line106-15.adsl.actcom.co.il ([192.117.106.15]:40342 "EHLO
	www.veltzer.org") by vger.kernel.org with ESMTP id <S275874AbSIUDw1>;
	Fri, 20 Sep 2002 23:52:27 -0400
Message-Id: <200209210409.g8L49FC04271@www.veltzer.org>
Content-Type: text/plain; charset=US-ASCII
From: Mark Veltzer <mark@veltzer.org>
Organization: Meta Ltd.
To: "Rhoads, Rob" <rob.rhoads@intel.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project
Date: Sat, 21 Sep 2002 07:09:13 +0300
X-Mailer: KMail [version 1.3.2]
References: <D9223EB959A5D511A98F00508B68C20C0A5389A5@orsmsx108.jf.intel.com>
In-Reply-To: <D9223EB959A5D511A98F00508B68C20C0A5389A5@orsmsx108.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> This project is open to anyone who wants to participate and is
> being paid for by Intel and a host of other companies. The
> idea is to enable Linux to play in the Carrier space with all
> the work given away under the GPL.

Enable Linux to play in the Carrier space. That IS interesting. This is, I 
expect, as opposed to all the other operating systems which run on Intel 
platforms which are already robust and already play in the "Carrier space" ?
The patronization of commercial companies never ceases to amaze me...

Let me reverse this: Intel wants to play in the Carrier space and needs Linux 
to do it... Ok. Now we've got it right. I think this is what other posters 
thought of as "taking". Intel has everything to gain here since it was never 
a player in the "Carrier space".

Don't get me wrong, I'm not saying NO to free code but if we really have to 
come face to face with the truth then it's quite obvious from history that 
commercial companies aren't that hot when it comes to coding (it's my general 
experience that code that comes out of commercial companies needs to be more 
heavily reviewed bacause marketing/featurism and deadlines produce bad 
code...).

Regarding marketing slogans. Even a bad mouse driver can screw up your 
system. This means that you just have to write good driver code. I certainly 
wouldn't want all of this commercial bla bla to turn into a big fat API where 
old and new semantics are mixed and are not clear like in the "other" carrier 
grade operating system which is well known and runs on Intel. APIs have to be 
as lean as possible with robust semantics. This should not change and this is 
actually the chief strength of Linux (because all driver code is available 
the API is quite mature and robust). All that is left to do is improve driver 
code. So why don't you call the project "Driver improvement project" or 
something like that and drop the commercial bla bla. Under this title the 
project has probably been going on (under some form or another) since 1991.

> What paying professional developers to work on an Open Source project
> and giving their work away under the terms of the GPL isn't enough?

You mean when Intel finally gets a real operating system to run on it's 
machines for PRACTICALLY NOTHING ?!? I think Intel is getting a real sweet 
deal here. I would love to be a chip maker and get a full operating system 
(with thousands of applications and a full desktops) for the price of a few 
developers. Also the big commercial noise that such a project would generate 
would probably win a few fat accounts away from SUN eh ?!?

BTW: would you be paying developers to work on other architecture drivers too 
? ! ? That would be interesting but I guess the answer is no... This is a 
major problem since the arsenal of tools at the disposal of a driver coder in 
Linux is quite generic (with regard to platform). When you aim to produce a 
driver just for i386 you tend to hardcode x86 details into your driver which 
makes for a bad driver since using the platform agnostic Linux arsenal would 
probably produce a better driver. You do code for x86 but if you are 
developing a mixed set of drivers (for different archs) then you tend to 
understand the generic tools semantics better and use them better which in 
turn produces better drivers. It may sound strange but when coding in Linux 
you're better off being familiar with several archs and working on details of 
several archs because you tend to produce better drivers that way (even if 
the drivers are arch specific). The generic tools that you mentioned 
(regarding more robust error handling etc..) which seem to me like 
improvements in API would certainly need to be approved for ALL architectures 
which in turn will need a big janitor type project which means that it's out 
of this development cycle.

Mark.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9i/DpxlxDIcceXTgRAkWxAJ9vUND+LnzCg3c0dQepZ6sYFwBkEwCgvVpb
YA6gC8XeeM4Ct/w44SHXLhA=
=HP4A
-----END PGP SIGNATURE-----
