Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288981AbSBFKQr>; Wed, 6 Feb 2002 05:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290062AbSBFKQf>; Wed, 6 Feb 2002 05:16:35 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:42638 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S288981AbSBFKQZ>;
	Wed, 6 Feb 2002 05:16:25 -0500
To: Telford002@aol.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [HDLC] Purpose of this Driver?
In-Reply-To: <107.c6a18b1.29907d5b@aol.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 05 Feb 2002 13:30:30 +0100
In-Reply-To: <107.c6a18b1.29907d5b@aol.com>
Message-ID: <m3wuxsw1p5.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Telford002@aol.com writes:

> HDLC is somewhat ambiguous.  CCITT/ITU documents use HDLC
> to refer to a whole class of protocols.  By raw HDLC, I believe is
> meant a specific BOP (Bit-Oriented Protocl) where flags encapsulate
> frames and the transmitter performs bit insertion and the 
> receiver performs bit deletion.  Even if the usual 0x7e flags
> are used with the standard bit insertion/deletion algorithm, there
> are still two variants, one with flag idles and the other with
> mark idles.

Plus there are different CRCs or no CRC (FCS) at all.
In fact, we're using "idle flags" version only (?).

> Is there a document that attempts to specificy the type of
> WAN interface that is a goal?  In truth, if the intent is the
> specification of a generic WAN interface, I would recommend
> aiming for more generality than basic flag-framing and bit-insertion
> bit-deletion BOP.

Not sure what do you mean - we don't aim at raw HDLC only. Raw HDLC
is included for completness, as well as things like FR or PPP are.

If you think of different encapsulation, it can be added of course.
-- 
Krzysztof Halasa
Network Administrator
