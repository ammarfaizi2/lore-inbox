Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289089AbSANWMY>; Mon, 14 Jan 2002 17:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289091AbSANWMG>; Mon, 14 Jan 2002 17:12:06 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:36546 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S289089AbSANWL6>; Mon, 14 Jan 2002 17:11:58 -0500
Date: Mon, 14 Jan 2002 14:11:48 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Ian Molton <spyro@armlinux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <20020114205124.2f05fc56.spyro@armlinux.org>
Message-ID: <Pine.LNX.4.40.0201141409580.22904-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the impact is in all calls to the module, if they are far calls instead of
near calls each and every call is (a hair) slower.

so the code can be the same and still be slower to get to.

you can argue that it's not enough slower to matter, but even Alan admits
there is some impact.

David Lang

On Mon, 14 Jan 2002, Ian Molton wrote:

> Date: Mon, 14 Jan 2002 20:51:24 +0000
> From: Ian Molton <spyro@armlinux.org>
> To: linux-kernel@vger.kernel.org
> Subject: Re: Hardwired drivers are going away?
>
> On a sunny Mon, 14 Jan 2002 11:44:59 -0800 (PST) David Lang gathered a
> sheaf of electrons and etched in their motions the following immortal
> words:
>
> > doesn't matter, they are likly to be found on dedicated servers where
> > the flexibility of modules is not needed and the slight performance
> > advantage is desired.
>
> Exactly WHAT performance advantage? once the module is loaded, its loaded.
> most modules use the same code to handle modular and non-modular builds
> anyhow (look at the ide drivers, for example)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
