Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291019AbSBGBTv>; Wed, 6 Feb 2002 20:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291027AbSBGBTl>; Wed, 6 Feb 2002 20:19:41 -0500
Received: from [208.147.64.186] ([208.147.64.186]:64725 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S291019AbSBGBT1>; Wed, 6 Feb 2002 20:19:27 -0500
Date: Thu, 31 Jan 2002 15:43:28 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Jeff Garzik <garzik@havoc.gtf.org>
cc: "David S. Miller" <davem@redhat.com>, <vandrove@vc.cvut.cz>,
        <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <paulus@samba.org>, <davidm@hpl.hp.com>, <ralf@gnu.org>
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
 not
In-Reply-To: <20020131180842.A13730@havoc.gtf.org>
Message-ID: <Pine.LNX.4.44.0201311543020.12657-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remember that CML2 claims to be able to detect that it needs to be on and
turn it on when needed

David Lang

On Thu, 31 Jan 2002, Jeff Garzik wrote:

> Date: Thu, 31 Jan 2002 18:08:42 -0500
> From: Jeff Garzik <garzik@havoc.gtf.org>
> To: David S. Miller <davem@redhat.com>
> Cc: vandrove@vc.cvut.cz, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
>      paulus@samba.org, davidm@hpl.hp.com, ralf@gnu.org
> Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3
>     does not
>
> On Thu, Jan 31, 2002 at 02:59:04PM -0800, David S. Miller wrote:
> > As a side note, this thing is so tiny (less than 4K on sparc64!) so
> > why don't we just include it unconditionally instead of having all
> > of this "turn it on for these drivers" stuff?
>
> Does that 4K include the BE and LE crc tables?
>
> <shrug>  I don't mind much either way, except that I am general
> resistant to "turn this on unconditionally" for bloat reasons.
> [ie. its a reflex :)]
>
> 	Jeff
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
