Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312431AbSCYOuE>; Mon, 25 Mar 2002 09:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312442AbSCYOty>; Mon, 25 Mar 2002 09:49:54 -0500
Received: from cambot.suite224.net ([209.176.64.2]:22291 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S312431AbSCYOtj>;
	Mon, 25 Mar 2002 09:49:39 -0500
Message-ID: <002301c1d40c$eb2bd920$b0d3fea9@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <cooker@linux-mandrake.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203251316560.26580-100000@luna.ellen.dexterslabs.com>
Subject: Re: [Cooker] (RFC) Supermount 2
Date: Mon, 25 Mar 2002 09:54:07 -0500
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


----- Original Message -----
From: <danny@mailmij.org>
To: <cooker@linux-mandrake.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, March 25, 2002 7:21 AM
Subject: Re: [Cooker] (RFC) Supermount 2


>
> On Mon, 25 Mar 2002, Matthew D. Pitts wrote:
> >
> > I am starting to plan a new version of Supermount. I have some things I
want to try out in it, and I will list them in this message. I am willing to
accept any and all input on what I am wanting to call Supermount 2.
> > Planned features of Supermount 2:
> >
> > 1) Auto-detection of filesystem type.
> Meaning we will finally have CD-tracks visualized as WAV files? like CD-fs
> does? Same goes for multisession disks.

I will try to do that, though it may mean hacking into the isofs driver.

> > 2) Supermount modules for each filesystem type.
> How is this on performance (first check for fs type than loading module?
> than disk is removed, unloading module and loading another one?)

I haven't gotten that far, yet. How well it works depends a lot on how much
of the information about the disk can be read by Supermount 2 when the disk
is inserted.

> > 3) Built-in support for packet-writing. ( i.e. insert packet-writing
formatted disk and it loads appropriate kernel modules. )
> >
> > There may be other features added if there is an interest in them. I
will need assistance with the packet-writing support. I am only planning to
do this for the 2.5.x and later kernels, so if anyone else wishes to
back-port it to an older kerenl series, by all means do so. I have wanted to
make some kind of contribution to this project for some time and I feel that
this is something that will be useful.
> >
> What about doing it in userspace? I remember seeing Alan Cox writing he
> had a proof of concept of something like this on some ftp server (sorry,
> cannot remember where).

I am going to go over Alan's code when I have a decent machine to work
with...

>
> > I am going to be making my prelminary code available to whomever wishes
to see it once I get my Linux box back up.
> sure
>
>
>
> Danny
>
> >
> > Matthew D. Pitts
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

