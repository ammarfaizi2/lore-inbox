Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130075AbQLMFeK>; Wed, 13 Dec 2000 00:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131003AbQLMFdt>; Wed, 13 Dec 2000 00:33:49 -0500
Received: from [200.216.82.160] ([200.216.82.160]:7177 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S130075AbQLMFdt>; Wed, 13 Dec 2000 00:33:49 -0500
Date: Wed, 13 Dec 2000 03:03:11 -0200
From: Frédéric L . W . Meunier 
	<0@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: USB mass storage backport status?
Message-ID: <20001213030311.I1245@pervalidus>
In-Reply-To: <20001213014154.H1245@pervalidus> <20001212200840.K23762@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001212200840.K23762@one-eyed-alien.net>; from mdharm-kernel@one-eyed-alien.net on Tue, Dec 12, 2000 at 08:08:40PM -0800
X-Mailer: Mutt/1.2.5i - Linux 2.2.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 08:08:40PM -0800, Matthew Dharm wrote:
> Depending on the type of device you have and how you use it, it can either:
> (1) Work properly
> (2) Corrupt your data
> (3) Crash the driver
> (4) Crash your system

The reboot was about Iomega's Zip Drive under 2.2.18pre21:

http://slashdot.org/comments.pl?sid=00/12/11/2355217&threshold=0&commentsort=1&mode=thread&cid=110
 
> It's allready labeled EXPERIMENTAL.  Perhaps it should be labeled
> DANGEROUS, also, but how many labels can you put on things to warn people
> off?

Hmm, where? I don't see an (EXPERIMENTAL) in
Documentation/Configure.help:

USB Mass Storage support
CONFIG_USB_STORAGE
Say Y here if you want to connect USB mass storage devices to your
computer's USB port.

This code is also available as a module ( = code which can be
inserted in and removed from the running kernel whenever you want).
The module will be called usb-storage.o. If you want to compile it
as a module, say M here and read Documentation/modules.txt.

USB Mass Storage verbose debug
CONFIG_USB_STORAGE_DEBUG
Say Y here in order to have the USB Mass Storage code generate
verbose debugging messages.

Maybe it's only enabled when you set CONFIG_EXPERIMENTAL? I don't know, because I enabled
it to just set CONFIG_FB.

> On Wed, Dec 13, 2000 at 01:41:54AM -0200, Frédéric L . W . Meunier wrote:
> > What's the real status of the mass storage backport to 2.2.18?
> > Some people report it can corrupt your data, another that it
> > rebooted his computer while doing a large trasnfer, and so on.
> > 
> > If it's not good, shouldn't it be removed or labeled
> > DANGEROUS? BTW, where can I see a list of what's backported
> > and working without major problems?

-- 
0@pervalidus.{net,{dyndns.}org} TelFax: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
