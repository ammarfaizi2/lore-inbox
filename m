Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264340AbRFYWT7>; Mon, 25 Jun 2001 18:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264376AbRFYWTu>; Mon, 25 Jun 2001 18:19:50 -0400
Received: from 24.157.217.96.on.wave.home.com ([24.157.217.96]:36369 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S264340AbRFYWT3>;
	Mon, 25 Jun 2001 18:19:29 -0400
Date: Mon, 25 Jun 2001 18:20:23 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: EXT2 Filesystem permissions (bug)?
In-Reply-To: <9h8b8q$s95$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.30.0106251819580.20791-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oh ;)

I never noticed that info before, then again 2 hours of sleep might be the
cause :)

On 25 Jun 2001, H. Peter Anvin wrote:

> Followup to:  <Pine.LNX.4.30.0106251729450.18996-100000@coredump.sh0n.net>
> By author:    Shawn Starr <spstarr@sh0n.net>
> In newsgroup: linux.dev.kernel
> >
> > Is this a bug or something thats undocumented somewhere?
> >
> > d--------T
> > and
> > drwSrwSrwT
> >
> > are these special bits? I'm not aware of +S and +T
> >
>
> It's neither a bug nor undocumented.
>
> "info ls" would have told you the following:
>
>      The permissions listed are similar to symbolic mode
>      specifications
>      (*note Symbolic Modes::.).  But `ls' combines multiple bits into
>      the third character of each set of permissions as follows:
>     `s'
>           If the setuid or setgid bit and the corresponding executable
>           bit are both set.
>
>     `S'
>           If the setuid or setgid bit is set but the corresponding
>           executable bit is not set.
>
>     `t'
>           If the sticky bit and the other-executable bit are both set.
>
>     `T'
>           If the sticky bit is set but the other-executable bit is not
>           set.
>
>     `x'
>           If the executable bit is set and none of the above apply.
>
>     `-'
>           Otherwise.
>
> 	-hpa
> --
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

