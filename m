Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132605AbRDXAUf>; Mon, 23 Apr 2001 20:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbRDXAUZ>; Mon, 23 Apr 2001 20:20:25 -0400
Received: from mail.valinux.com ([198.186.202.175]:41736 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S132605AbRDXAUO>;
	Mon, 23 Apr 2001 20:20:14 -0400
Date: Mon, 23 Apr 2001 18:34:01 -0600
From: Don Dugger <n0ano@valinux.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Manuel McLure <manuel@mclure.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel hang on multi-threaded X process crash
Message-ID: <20010423183401.C13382@tlaloc.n0ano.com>
In-Reply-To: <20010423082405.C979@ulthar.internal.mclure.org> <E14riRj-0008HH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E14riRj-0008HH-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 23, 2001 at 04:40:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan-

I certainly care to fix it (since I wrote the patch).  Since `aviplay' seems
to be the easy way to trigger it I'll look into it.

On Mon, Apr 23, 2001 at 04:40:12PM +0100, Alan Cox wrote:
> > Both mozilla and aviplay (which are both multithreaded) trigger this - I
> > haven't tried with xmms. Simpler programs like xclock or cat don't trigger
> > it.
> 
> Thanks. I'll revert the core dump stuff for 2.4.4-ac unless anyone cares to
> fix the fix
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@valinux.com
Ph: 303/938-9838
