Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129445AbRAWRhR>; Tue, 23 Jan 2001 12:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAWRhH>; Tue, 23 Jan 2001 12:37:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:3588 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129445AbRAWRgy>; Tue, 23 Jan 2001 12:36:54 -0500
Date: Tue, 23 Jan 2001 13:46:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 3-order allocation failed. for 2.4.1-pre9
In-Reply-To: <20010123155935.552E9635@popeye.ipv6.univ-nantes.fr>
Message-ID: <Pine.LNX.4.21.0101231335230.9589-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23 Jan 2001, Yann Dupont wrote:

> I remember sawing that those errors were due to improperly written
> drivers . Is the buslogic driver or tape driver are to blame here ?? Or
> maybe this is a vm balancing issue ?

Could you please send the output of "Alt+SysRq+m" (kernel must be compiled
with CONFIG_MAGIC_SYSRQ option) when the buffer cache is near 100MB in
size?

Thanks



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
