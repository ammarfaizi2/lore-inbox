Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132127AbRDCPhq>; Tue, 3 Apr 2001 11:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132167AbRDCPh1>; Tue, 3 Apr 2001 11:37:27 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:21510 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132127AbRDCPhT>;
	Tue, 3 Apr 2001 11:37:19 -0400
Date: Tue, 3 Apr 2001 11:34:11 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: <Wayne.Brown@altec.com>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <Andries.Brouwer@cwi.nl>, <torvalds@transmeta.com>,
        <alan@lxorguk.ukuu.org.uk>, <hpa@transmeta.com>,
        <linux-kernel@vger.kernel.org>, <tytso@MIT.EDU>
Subject: Re: Larger dev_t
In-Reply-To: <86256A23.00517DBD.00@smtpnotes.altec.com>
Message-ID: <Pine.LNX.4.30.0104031129400.6886-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2001, Wayne.Brown@altec.com wrote:

> Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de> wrote:
>
> >Yes: Let "mknod /dev/foo [bc] x y" die!
>
> I hope this never happens.  Improving the major/minor device scheme is
> reasonable; abandoning it would be a sad occurrence.  It would make Linux too
> "un-UNIXish"  (how's THAT for an an ugly neologism!) for my tastes.

I don't know... the command 'mknod' should probably remain for
compatibility reasons.  But the way that it does create the node can be
completely different.  For example the call could just be a wrapper to a
syscall or a write to a proc file.

I think Ingo had qualms with the process of creating of a device file
which is totally detached of the kernel's ability to service that device.

But I am with you.  The compatibility between *NIX should not be severed
so fast.

B.

-- 
	WebSig: http://www.jukie.net/~bart/sig/



