Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280153AbRLDC43>; Mon, 3 Dec 2001 21:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281887AbRLCXsK>; Mon, 3 Dec 2001 18:48:10 -0500
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:49088 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S284957AbRLCTBS>; Mon, 3 Dec 2001 14:01:18 -0500
Message-ID: <3C0BCBBC.C8ED1FE2@pp.inet.fi>
Date: Mon, 03 Dec 2001 21:00:12 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Valerio Riedel <hvr@hvrlab.org>
CC: Andrea Arcangeli <andrea@suse.de>, axboe@suse.de, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: RFC(ry): breaking loop.c's IV calculation
In-Reply-To: <3C0A51B0.9AD14E74@pp.inet.fi>
			<Pine.LNX.4.33.0112021716001.2563-100000@janus.txd.hvrlab.org> 
			<20011202234625.A3447@athlon.random> <1007388763.1674.37.camel@janus.txd.hvrlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Valerio Riedel wrote:
> well, I've put one patch together (it still needs (constructive)
> auditing though! jari?) here it is (it's against 2.4.16's loop.[ch])

1)  For 2.4 kernels, IV type must remain int, not loop_iv_t, ok?
    Make the type loop_iv_t for 2.5 kernels but not for 2.4.

2)  Get rid of the loop_get_bs() crap.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

