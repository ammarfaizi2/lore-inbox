Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270817AbRHSWTA>; Sun, 19 Aug 2001 18:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270822AbRHSWSu>; Sun, 19 Aug 2001 18:18:50 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:6628 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270817AbRHSWSm>;
	Sun, 19 Aug 2001 18:18:42 -0400
Date: Sun, 19 Aug 2001 23:18:53 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>, lists@sapience.com,
        Robert Love <rml@tech9.net>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Entropy from net devices - keyboard & IDE just as 'bad' [was
 Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
Message-ID: <481868510.998263132@[169.254.45.213]>
In-Reply-To: <481261630.998262525@[169.254.45.213]>
In-Reply-To: <481261630.998262525@[169.254.45.213]>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that by repeating reading (as a user) I should be able to
> get the inter-IRQ timing down to a few tens of microseconds,

& (as per add_timer_randomness) on all non-i386's and some
i386's, I actually only need to get the time within one jiffy.
Do this on 4 successive IRQ's, and that's 12 bits of 'false'
entropy. But the point is, it's no worse for network than
for the rest.

--
Alex Bligh
