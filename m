Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131488AbRCWW3h>; Fri, 23 Mar 2001 17:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRCWW33>; Fri, 23 Mar 2001 17:29:29 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:51978 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S131479AbRCWW2h>; Fri, 23 Mar 2001 17:28:37 -0500
Date: Sat, 24 Mar 2001 00:37:16 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Guest section DW <dwguest@win.tue.nl>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <E14gZvi-0005YW-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103240030310.13864-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Mar 2001, Alan Cox wrote:
> > > and rely on it. You might find you need a few Gbytes of swap just to
> > > boot
> > Seems a bit exaggeration ;) Here are numbers,
> NetBSD is if I remember rightly still using a.out library styles.

No, it uses ELF today, moreover the numbers were from Solaris. NetBSD
also switched from non-overcommit to overcommit-only [AFAIK] mode with
"random" process killing with its new UVM.

> > 6-50% more VM and the performance hit also isn't so bad as it's thought
> > (Eduardo Horvath sent a non-overcommit patch for Linux about one year
> > ago).
> The Linux performance hit would be so close to zero you shouldnt be able to
> measure it - or it was in 1.2 anyway

Yep, something like this :)

	Szaka

