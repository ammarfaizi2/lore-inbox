Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280484AbRKFT1t>; Tue, 6 Nov 2001 14:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280291AbRKFT1i>; Tue, 6 Nov 2001 14:27:38 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:38416 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S280266AbRKFT1d>; Tue, 6 Nov 2001 14:27:33 -0500
Message-Id: <200111061912.fA6JCSn19807@numbat.os2.ami.com.au>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: John Summerfield <summer@os2.ami.com.au>, linux-kernel@vger.kernel.org,
        summer@numbat.os2.ami.com.au
Subject: Re: Olivetti hangs in PCI initialisation 
In-Reply-To: Message from Rasmus Andersen <rasmus@jaquet.dk> 
   of "Tue, 06 Nov 2001 19:39:15 +0100." <20011106193915.A821@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 03:12:28 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Nov 07, 2001 at 01:06:11AM +0800, John Summerfield wrote:
> > 
> > 
> > It's bizarre. The machine boots okay with the Red Hat Linux bootnet 
> > image for RHL 7.2, and starts running the installer - the the point of 
> > configuring my network card.
> > 
> > It was hanging at the point where I saw the message "PCI: Using 
> > configuration type 1."
> 
> Hi.
> 
> Some time ago I had an old Pentium Olivetti die on me during boot
> in pci-country. I could work around that with the boot parameter
> 'pci=conf1'. You seem to die in conf1. Maybe you should try out
> conf2 and see what happens?
>

An interesting idea. I didn't expect it to change anything - it doesn't 
look as if it's examining hardware at the critical moment, but then 
who's going to say the printed info appears on the terminal before it 
progresses to the next statement?

Well it went on and hung in ISAPnP checking.


I deleted the syslinux messages and got even further.

It sounds less bizarre now - it seems it can't scroll, but what next?

It's found the internal sound card and attached (bizarre - why does 
that word keep coming up) internal modem attached to the sound card.


-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my 
disposition.



