Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAICsM>; Mon, 8 Jan 2001 21:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAICsD>; Mon, 8 Jan 2001 21:48:03 -0500
Received: from cc493382-b.whmh1.md.home.com ([24.3.58.253]:4399 "EHLO
	legion.wienholt.net") by vger.kernel.org with ESMTP
	id <S129324AbRAICrv>; Mon, 8 Jan 2001 21:47:51 -0500
Reply-To: <elixer@erols.com>
From: "Sean R. Bright" <elixer@erols.com>
To: "'Michael D. Crawford'" <crawford@goingware.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: FS callback routines
Message-ID: <001401c079e6$0668bbe0$59aa0141@cc230545b>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3A5A4958.CE11C79B@goingware.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Date: Mon, 8 Jan 2001 21:37:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agreed.

I will have a look at the URLs you passed along.  I was talking to a
colleague about this just after I sent the initial message and the number of
places where this would be useful suddenly became much more apparent to me
:)  For example, _ANY_ daemon process could be notified of configuration
changes when they happen, mail servers/spoolers would have immediate access
to the locations of files, without tying up the disk with polling.  All and
all a very good idea (and its not even mine anymore it would seem, so I can
say that! :))

Thanks again,
Sean

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Michael D.
> Crawford
> Sent: Monday, January 08, 2001 6:12 PM
> To: linux-kernel@vger.kernel.org
> Subject: Re: FS callback routines
>
>
> Regarding notification when there's a change to the filesystem:
>
> This is one of the most significant things about the BeOS BFS
> filesystem, and
> something I'd dearly love to see Linux adopt.  It makes an
> app very efficient,
> you just get notified when a directory changes and you never
> waste time polling.
>
> I think it would require changes to the VFS layer, not just
> to the filesystems,
> because this is a concept POSIX filesystems do not presently possess.
>
> The other is indexed filesystem attributes, for example a
> file can have its
> mimetype in the filesystem, and any application can add an
> attribute and have it
> indexed.
>
> There's a method to do boolean queries on indexed attributes,
> and you can find
> files in an entire filesystem that match a query in a
> blazingly short time, much
> faster than walking the directory tree.
>
> If you want to try out the BeOS, there's a free-as-in-beer version at
> http://free.be.com for Pentium PC's.  You can also purchase a
> version that comes
> for both PC's and certain PowerPC macs.
>
> There are read-only versions of this for Linux which I
> believe are under the
> GPL.  The original author is here:
>
> http://hp.vector.co.jp/authors/VA008030/bfs/
>
> He refers you to here to get a version that works under 2.2.16:
>
> http://milosch.net/beos/
>
> The author's intention was to take it read-write, but it's
> complex because it is
> a journaling filesystem.
>
> Daniel Berlin, a BeOS developer modified the Linux BFS driver
> so it works with
> 2.4.0-test1.  I don't know if it works with 2.4.0.  The web
> site where it used
> to be posted isn't there anymore, and the laptop where I had
> it is in for
> repair.  I may have it on a backup, and I'll see if I can
> track Daniel down.
>
> While Be, Inc.'s implementation is closed-source, the design
> of the BFS (_not_
> "befs" as it is sometimes called) is explained in Practical
> File System Design
> with the Be File System by Dominic Giampolo, ISBN
> 1-55860-497-9.  Dominic has
> since left Be and I understand works at Google now.
>
>
> --
> Michael D. Crawford
> GoingWare Inc. - Expert Software Development and Consulting
> http://www.goingware.com/
> crawford@goingware.com
>
>    Tilting at Windmills for a Better Tomorrow.
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
