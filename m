Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131768AbRAKS17>; Thu, 11 Jan 2001 13:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbRAKS1j>; Thu, 11 Jan 2001 13:27:39 -0500
Received: from mail11.verio.de ([213.198.0.60]:14619 "HELO mail11.verio.de")
	by vger.kernel.org with SMTP id <S130255AbRAKS1a>;
	Thu, 11 Jan 2001 13:27:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Michael Meding <Michael@Meding.net>
Reply-To: Michael@Meding.net
To: "Matthew D. Pitts" <mpitts@suite224.net>
Subject: Re: Compile error: DRM without AGP in 2.4.0
Date: Thu, 11 Jan 2001 19:18:49 +0100
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0101111238210.1732-100000@phantasy.awol.org> <001101c07bfa$daf36ac0$0100a8c0@pittscomp.com>
In-Reply-To: <001101c07bfa$daf36ac0$0100a8c0@pittscomp.com>
MIME-Version: 1.0
Message-Id: <01011119184900.01187@Hal>
Content-Transfer-Encoding: 7BIT
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 11. January 2001 19:18, Matthew D. Pitts wrote:
> Robert,
>
> > On Thu, 11 Jan 2001, Giacomo Catenazzi spoke:
> > > Here a valid configuration (no AGP, but all DRM set)
> > > compiling [2.4.0]:
> > > [...]
> >
> > DRM requires AGPGART.
>
> What if your motherboard doesn't have an AGP slot? I'm running an older
> Micro Star pentium with a ATI All-in-Wonder with the Rage 128 chipset.
>
> Matthew
> mpitts@suite224.net

Hi,

then you are out of luck, until the pcigart is finished. Or use another 
vidcard like the voodoo. IMHO they don't need AGPGART.

Greetings,

Michael

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
