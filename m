Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263473AbRFSDWi>; Mon, 18 Jun 2001 23:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263487AbRFSDW2>; Mon, 18 Jun 2001 23:22:28 -0400
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:23556 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S263473AbRFSDWS>;
	Mon, 18 Jun 2001 23:22:18 -0400
Date: Mon, 18 Jun 2001 23:23:02 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: Olivier Galibert <galibert@pobox.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.6-pre3 breaks ReiserFS mount on boot
In-Reply-To: <20010618231435.A6398@zalem.puupuu.org>
Message-ID: <Pine.LNX.4.30.0106182320510.2168-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Two things:

1) It broke apparently with gcc 2.95.3 when patching from 2.4.6-pre2 ->
2.4.6pre3

2) I tried building it with gcc 3.00 and had same result.

3) I now have gcc 3.00 and going to rebuild 2.4.6-pre2 and see if reiserfs
panics if it doesn't there's an issue with the new pre3 modifications.

I hope ReiserFS *MAINTAINS* compatability from slightly older revisions,
or even migrates systems over to handle new issues.

Shawn.

On Mon, 18 Jun 2001, Olivier Galibert wrote:

> On Mon, Jun 18, 2001 at 10:58:57PM -0400, Shawn Starr wrote:
> > When diffing 2.4.6-pre2 & pre3 I noticed some reiserfs code was changed.
> > This seems to cause VFS to panic via reiserfs.
> >
> > Anyone else notice this?
>
> I don't, and I boot on reiserfs.
>
>   OG.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

