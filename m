Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271223AbRHTN5O>; Mon, 20 Aug 2001 09:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271215AbRHTN5D>; Mon, 20 Aug 2001 09:57:03 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:30693 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271213AbRHTN4z>;
	Mon, 20 Aug 2001 09:56:55 -0400
Date: Mon, 20 Aug 2001 14:57:03 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Johan Adolfsson <johan.adolfsson@axis.com>
Cc: Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <2248596630.998319423@[10.132.112.53]>
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com>
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The device get's powerd up at a random time for the attacker.
> That's entierly sufficient if you assume that your checksum function
> f(i) hat the property that there is no function g, where we have
> f(i+1)=g(f(i)), where g has a polynomial order over the time domain.
> i is unknown for the attacker.

So, your argument is that there is no point in all this
entropy collection anyway. So if everything is hunky dory,
why have /dev/random block under such a circumstance?
(which was the original poster's  problem).

--
Alex Bligh
