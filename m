Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280931AbRKKFGO>; Sun, 11 Nov 2001 00:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280932AbRKKFGE>; Sun, 11 Nov 2001 00:06:04 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:49803 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S280931AbRKKFFv>;
	Sun, 11 Nov 2001 00:05:51 -0500
Date: Sun, 11 Nov 2001 00:05:50 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Any lingering Athlon bugs in Kernel 2.4.14?
In-Reply-To: <E162YXo-0006P8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0111110002590.22386-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2001, Alan Cox wrote:

> > really think 2.4.13-ac7 has some cool hw bug workarounds? I guess I should
> > read about what went into -ac7.... Where would be a good place to find
> > more info?
>
> If you want to be predictable about your test set then you can simply pull
> the VIA Athlon workaround pci quirk form 2.4.13-ac or 2.4.14 and merge it
> with your base 2.4.2, or 2.4.2-rh whatever tree.
>
> In fact you can do it in userspace with setpci if thats politically optimal
> 8)
>
>
> Alan
>

Alan:

Good idea.. I actually would like to be scientific about it by sticking
to the kernel that the machines came with, and just trying the VIA Athlon
workaroung pci quirk on those kernels... that way I can experiment and see
if it makes much of a difference.

I suppose this question is stuff I can find elsewhere but: where do I find
just that patch alone (so that I cen see about adapting it to my redhat
kernel) and/or how do I do it from userspace ;) (i assume i just have to
write to some registers or something using some user-space mechanism that
i am unaware of???).

-Calin

