Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274489AbRITNhH>; Thu, 20 Sep 2001 09:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274491AbRITNg5>; Thu, 20 Sep 2001 09:36:57 -0400
Received: from maila.telia.com ([194.22.194.231]:35285 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S274489AbRITNgn>;
	Thu, 20 Sep 2001 09:36:43 -0400
Date: Thu, 20 Sep 2001 15:40:49 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: Nicholas Knight <tegeran@home.com>
Cc: Adrian Cox <adrian@humboldt.co.uk>, t.sailer@alumni.ethz.ch,
        Thomas Sailer <sailer@scs.ch>, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio locking problems
Message-ID: <20010920154049.A4282@telia.com>
Mail-Followup-To: Nicholas Knight <tegeran@home.com>,
	Adrian Cox <adrian@humboldt.co.uk>, t.sailer@alumni.ethz.ch,
	Thomas Sailer <sailer@scs.ch>, jgarzik@mandrakesoft.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BA9AB43.C26366BF@scs.ch> <01092004333500.00182@c779218-a> <3BA9DBED.9020401@humboldt.co.uk> <01092005243800.01369@c779218-a>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01092005243800.01369@c779218-a>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Knight <tegeran@home.com> wrote:

> Interesting, I just experimented with it, bringing down the buffers to 
> 200ms (low as they'll go) and pre-buffer % to 0, does seem to have an 
> effect, but it doesn't "fix" the problem for me...

I'm  using the VIA audio driver and I have what appears to be a very similar
problem:

When I try to move my XMMS window while playing a song the window sometimes
"gets stuck" for a second or so during the move. Moving the window without
any song playing works just fine. I also tried setting the buffer to 200ms
but it didn't solve it for me either.

dmesg reports:

Via 686a audio driver 1.1.14b
PCI: Found IRQ 10 for device 00:07.5
via82cxxx: Codec rate locked at 48Khz
ac97_codec: AC97 Audio codec, id: 0x8384:0x7600 (SigmaTel STAC????)
via82cxxx: board #1 at 0xDC00, IRQ 10
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
