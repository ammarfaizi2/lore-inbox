Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270478AbRHHNt0>; Wed, 8 Aug 2001 09:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270480AbRHHNtR>; Wed, 8 Aug 2001 09:49:17 -0400
Received: from smtp.monmouth.com ([209.191.58.6]:18962 "EHLO smtp.monmouth.com")
	by vger.kernel.org with ESMTP id <S270478AbRHHNtH>;
	Wed, 8 Aug 2001 09:49:07 -0400
Message-ID: <3B713546.C2023EDC@monmouth.com>
Date: Wed, 08 Aug 2001 08:49:10 -0400
From: Dipak <dipak@monmouth.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-6.1smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Leak in network memory?
In-Reply-To: <200108022222.CAA00348@mops.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I'm facing the effect of memory leak most probably. I've compiled 2.4.1
kernel. When I leave my m/c running overnight, I used to find the m/c has
become very slow. Any command from shell prompt takes too much of time to
execute. I don't have any other option but to reboot, which also takes too
much time to actually shutdown the m/c before re-booting. I've compiled the
2.4.1 kernel on 2.2.14 of RedHat 6.2 release.
    As I've no mail in follow-up of the following mail in this mailing-list,
I have no idea of what solution anybody had come up with if it is really a
memory leakage problem. Please help me in this regard.

Thanks in advance,
Dipak

Alexey Kuznetsov wrote:

> Hello!
>
> > buffers of sockets. All sockets are set to have 64KB (the default)
>
> Are you sure? Default is 16K.
>
> Alexey
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

