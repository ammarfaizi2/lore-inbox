Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265031AbSJWOtv>; Wed, 23 Oct 2002 10:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265032AbSJWOtu>; Wed, 23 Oct 2002 10:49:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17542 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265031AbSJWOtp>; Wed, 23 Oct 2002 10:49:45 -0400
Date: Wed, 23 Oct 2002 10:57:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: One for the Security Guru's
In-Reply-To: <20021023130251.GF25422@rdlg.net>
Message-ID: <Pine.LNX.3.95.1021023105535.13301A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Robert L. Harris wrote:

>   The consultants aparantly told the company admins that kernel modules
> were a massive security hole and extremely easy targets for root kits.
> As a result every machine has a 100% monolithic kernel, some of them
> ranging to 1.9Meg in filesize.  This of course provides some other
> sticky points such as how to do a kernel boot image.


It's the typical so-called Security Consultant's lies.  After all,
if they knew what they were doing you wouldn't need them. They
create phony scenarios and then "solve" them. For instance, they
will load a module using a "root kit". Look, your system needs to
have been broken into in order to load a module. It's already been
broken into, the module is just a Security Consultant lie.

To load a module, you need to be root. If you are root and you
shouldn't be, the system has been broken into. It's just that
simple. It's not possible for `insmod` or `depmod` to load a
module, sitting in a rogue user's directory, that suddenly gives
that rogue user some privileges that he or she didn't already have.

We had some Security Consultant idiot from some well-known
auditing agency declare that all Linux machines were vulnerable
to outside attacks and "continuing use of such software
could result in a investor lawsuit..."

Of course the attack against Linux was "true". If you put a
Linux machine (or Sun or whatever), on the outside of a firewall
it may be attacked, therefore vulnerable to attack. And, if
investors learned that you were so stupid as to put it outside
a firewall, you might get sued by the investors. It's all perfectly
true. It's a trick by liars that lie by telling irrefutable
truths. 

In a similar scenerio, a Windows machine might not even be attacked.
There is nothing to be gained, even as the operating system is 
compromised. It would likely crash before any proprietary information
could be obtained. One of the advantages of Windows is that it's
so awful that only GWBASIC users are interested in it, then only
to change the location of a GOTO ;^.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


