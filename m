Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289301AbSANXwE>; Mon, 14 Jan 2002 18:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289307AbSANXvy>; Mon, 14 Jan 2002 18:51:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27396 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289301AbSANXvp>;
	Mon, 14 Jan 2002 18:51:45 -0500
Message-ID: <3C436F0E.300611@mandrakesoft.com>
Date: Mon, 14 Jan 2002 18:51:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Telford002@aol.com
CC: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
In-Reply-To: <d7.11a4a260.2974c807@aol.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Telford002@aol.com wrote:
> 
> In a message dated 1/14/2002 5:32:46 PM Eastern Standard Time,
> jgarzik@mandrakesoft.com writes:
> 
> > "Eric S. Raymond" wrote:
> > > Penelope needs to build a kernel to support her exotic driver, but
> > she
> > > hasn't got more than the vaguest idea how to go about it.  The
> > > instructions with the driver source patch tell her to apply it at
> > the
> > > top level of a current Linux source tree and then just say "build
> > the
> > > kernel" before getting off into technicalia about the user-space
> > > tools.
> >
> > Very few hardware vendors give out kernel patches... if any.  The
> > end
> > user method of choice I've seen is a tarball with files to build, or
> > a
> > single .c file to build.  Kernel autoconfiguration for vendor
> > drivers
> > rarely comes into play, because the driver is built against the
> > "current
> > kernel" headers, but not with the standard kernel build system and
> > tools.
> >
> 
> When I provide drivers to hardware vendors (not many Linux so far,
> I have been working mostly in the Solaris and previously the Netware
> markets), I have built them with the standard kernel build system
> and tools.  Now the vendors may actually provide these drivers as
> you describe, but if there were reason, they could certainly supply
> them as patches.

Yes, but no one does so because patches break all the time.  C modules
built carefully for kernel compatibility are far more resistant to
change.  People are more likely to ship -binary- modules than patches.

In sum, Eric's example is unrealistic.

	Jeff


-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
