Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281620AbRKMMR7>; Tue, 13 Nov 2001 07:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281621AbRKMMRt>; Tue, 13 Nov 2001 07:17:49 -0500
Received: from mail307.mail.bellsouth.net ([205.152.58.167]:49824 "EHLO
	imf07bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281620AbRKMMRk>; Tue, 13 Nov 2001 07:17:40 -0500
Message-ID: <3BF10F4F.1E5D67A6@mandrakesoft.com>
Date: Tue, 13 Nov 2001 07:17:19 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio problems
In-Reply-To: <20011112220630.A1200@bruder.net> <20011113121907.A9058@telia.com> <004601c16c3c$8f865e70$1300a8c0@marcelo>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Borges Ribeiro wrote:
> 
> The problem with via82xx is that it is locked in 48000Hz (you can see this
> in dmesg) and cannot play in any other rate. With mplayer you can see
> messages such as requested 16000Hz got (480000) that explains why it sounds
> like chip'n'dale ;-). P.s. I don´t know why it works with xmms  but with
> mpg123 it refuses to play at all becouse these sound rates.

This is not a problem but a limitation of the hardware...  some software
(including ALSA kernel drivers and xmms) will perform software rate
conversion.

If your audio sounds like chip-n-dales, your audio software does not
support hardware with locked codec rates, or you did not set it up to do
so.

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

