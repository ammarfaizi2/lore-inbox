Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269356AbRHLQMd>; Sun, 12 Aug 2001 12:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269355AbRHLQMX>; Sun, 12 Aug 2001 12:12:23 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:9351 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S269356AbRHLQMJ>;
	Sun, 12 Aug 2001 12:12:09 -0400
Message-ID: <3B76AAD9.702EE37D@pobox.com>
Date: Sun, 12 Aug 2001 09:12:09 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Max Schattauer <smax@smaximum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: tun device: File descriptor in bad state(77)
In-Reply-To: <3B769CA4.11035.A9DFE2@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some bits changed under vtun at 2.4.6 IIRC.

I patched vtun for my own use with patches from
Kevin Fleming, made rpms, and called it 2.4a.
It's been working fine here -

Perhaps someone else on the vtun team can
offer more recent information.

cu

jjs

Max Schattauer wrote:

> Hi there!
>
> I graded up from kernel 2.4.5 to 2.4.8 and now have trouble with
> vtund 2.5b1 and tun 1.1.
>
> vtund[532]: Session st_sm[217.230.44.100:1577] opened
> vtund[532]: Can't allocate tun device. File descriptor in bad state(77)
> vtund[532]: Session st_sm closed
>
> Also
>
> root:~# cat /dev/net/tun
> cat: /dev/net/tun: File descriptor in bad state
>
> Tried to recompile both packages and created a new device but
> without effect.
>
> Best regards,
>
> Max
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

