Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284360AbRLRRgv>; Tue, 18 Dec 2001 12:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284337AbRLRRgl>; Tue, 18 Dec 2001 12:36:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6161 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S284335AbRLRRgc>;
	Tue, 18 Dec 2001 12:36:32 -0500
Message-ID: <3C1F7E9D.DED578C7@mandrakesoft.com>
Date: Tue, 18 Dec 2001 12:36:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff <piercejhsd009@earthlink.net>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA sound and SNDCTL_DSP_NONBLOCK error.....
In-Reply-To: <3C1EEDFF.231F36B8@earthlink.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff wrote:
> 
> I am a ham radio operator who wishes to use the sound card for digital
> comunications. However, my system has the VIA 82c686/ac97 sound. While I
> can ofcourse make the sound work, playing/recording,etc, I cannot use it
> with ham software.
> Take twpsk31 for example, it compiles, but when trying to run it stops
> on:
> SNDCTL_DSP_NONBLOCK: illegal parameter.

update the software to use normal fcntl(2)

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
