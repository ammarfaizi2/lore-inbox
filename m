Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbSAGRWh>; Mon, 7 Jan 2002 12:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282690AbSAGRW3>; Mon, 7 Jan 2002 12:22:29 -0500
Received: from ns.suse.de ([213.95.15.193]:58637 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282684AbSAGRWT>;
	Mon, 7 Jan 2002 12:22:19 -0500
Date: Mon, 7 Jan 2002 18:22:17 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@ns.caldera.de>, Jaroslav Kysela <perex@suse.cz>,
        <sound-hackers@zabbo.net>, <linux-sound@vger.rutgers.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <Pine.LNX.4.33.0201070858150.6450-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201071818310.16327-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Linus Torvalds wrote:

> So we could have a net-based setup, where there would be a totally
> separate "linux/sound" and "linux/drivers/sound". Which doesn't seem to
> make much sense either.

If I want to find the code for an emu10k1 driver, intuition tells me
its a sound _driver_, so drivers/ would be the first place I (and no
doubt others) would look.

'core' sound stuff in linux/sound, with _driver_ specifics in
drivers/sound sounds perfectly sensible to me.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

