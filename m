Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTABCt0>; Wed, 1 Jan 2003 21:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbTABCt0>; Wed, 1 Jan 2003 21:49:26 -0500
Received: from hibernia.jakma.org ([212.17.32.129]:18054 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S265570AbTABCtY>; Wed, 1 Jan 2003 21:49:24 -0500
Date: Thu, 2 Jan 2003 02:57:48 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Rik van Riel <riel@conectiva.com.br>, <Hell.Surfers@cwctv.net>,
       <linux-kernel@vger.kernel.org>, <rms@gnu.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <20030102013736.GA2708@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44.0301020245080.8691-100000@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Bill Huey wrote:

> On Thu, Jan 02, 2003 at 12:31:13AM +0000, Paul Jakma wrote:

> > subsystem, the VFS, etc.. These systems are rather large bodies of
> > code - without which the NVidia kernel driver could not work.
> 
> Well, no, look at the "nm" dump of the object file. It's got a lot of
> proprietary code 

indeed. that doesnt change the fact that this large body of NVidia
specific code still must make use of large parts of linux code
(through function calls).

> It's a very practical solution to do it this way.

yes, but the legalities of it are rather grey.

> > How are the standard interfaces not covered by the GPL? 
> 
> All I saw where kernel header files include in the sources, nothing
> more. 

indeed, and if that were the only issue it would be clear there is no 
issue. however, it must make use of linux code at runtime through 
function calls - as linux makes use of the NVidia proprietary code by 
calling the functions it provides.

> I'd rather have the experts do it at NVidia, than a half completed
> open source implementation that isn't terribly optimized.

I run systems that use many GPL and fully open drivers that are quite
well optimised. Some of these drivers were written by the vendor's
"experts" and are distributed seperately - still GPL though.  
Sometimes one has a choice between drivers written by the vendor and
drivers written by (non-expert???) "community" authors, and often one
finds the vendor driver is the one that isn't terribly optimised.

> Matrix multiplies, T&L, etc...

none of this stuff is done in kernel (least it shouldnt be). Its done 
in user-space libraries.

The XFree licence allows binary only modules, indeed XFree 4 was 
designed to make distribution of (possibly binary) modules as easy as 
possible.

There isnt that much magic the NVidia kernel modules ought to be 
doing really.

> communication between user and kernel space that provides this to
> the OpenGL libraries are all exotic. I'm glad that nobody has to
> deal with this stuff directly and that a vendor is willing to
> provide support for it.

aha.. yes, all that complicated hardware stuff - you dont really want 
those linux kernel amatuers writing that.

> bill

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
The system will be down for 10 days for preventive maintenance.

