Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312139AbSCQXtN>; Sun, 17 Mar 2002 18:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312138AbSCQXtD>; Sun, 17 Mar 2002 18:49:03 -0500
Received: from cambot.suite224.net ([209.176.64.2]:5388 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S312137AbSCQXso>;
	Sun, 17 Mar 2002 18:48:44 -0500
Message-ID: <003901c1ce0e$e5c15040$b0d3fea9@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020316190415.38CE14E534@mail.vnsecurity.net> <E16mLFj-000794-00@the-village.bc.nu> <20020317053624.GD23938@matchmail.com>
Subject: Re: Linux 2.4.19-pre3-ac1
Date: Sun, 17 Mar 2002 18:52:51 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L-K developers,

What is the recomended amount of swap if you have a PC with 384 MB ram?

Matthew
----- Original Message -----
From: Mike Fedyk <mfedyk@matchmail.com>
To: <MrChuoi@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, March 17, 2002 12:36 AM
Subject: Re: Linux 2.4.19-pre3-ac1


> On Sat, Mar 16, 2002 at 08:58:11PM +0000, Alan Cox wrote:
> > > SwapTotal:       65528 kB
> > > SwapFree:        65528 kB
> > > Committed_AS:    57252 kB
> >
> > Ok at this point you have 64Mb of free swap, and at worse (absolutely
worst
> > pure theory) have 57Mb committed
> >
> > > LowTotal:       126856 kB
> > > SwapTotal:       65528 kB
> > > SwapFree:        63324 kB
> > > Committed_AS:   226160 kB
> >
> > So you have 128Mb of RAM, 64Mb of swap, and if all pages are touched you
> > would need 226Mb of swap + ram (minus kernel overhead). Looks like the
> > machine is hovering on the edge
> >
>
> In Other Words (IOW), add more swap like everyone else said.
>
> The rmap design does use a bit more memory (about 400k for 128MB ram) for
> the reverse mapping tables, so that could push you over into an OOM case.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

