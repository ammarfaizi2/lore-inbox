Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276957AbRJDXU2>; Thu, 4 Oct 2001 19:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277020AbRJDXUT>; Thu, 4 Oct 2001 19:20:19 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:16815 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S276957AbRJDXUJ>;
	Thu, 4 Oct 2001 19:20:09 -0400
Date: Fri, 05 Oct 2001 00:20:34 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Benjamin LaHaise <bcrl@redhat.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: mingo@elte.hu, jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <309455016.1002241234@[195.224.237.69]>
In-Reply-To: <20011004174945.B18528@redhat.com>
In-Reply-To: <20011004174945.B18528@redhat.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, 04 October, 2001 5:49 PM -0400 Benjamin LaHaise 
<bcrl@redhat.com> wrote:

>> In at least one environment known to me (router), I'd rather it
>> kept accepting packets, and f/w'ing them, and didn't switch VTs etc.
>> By dropping down performance, you've made the DoS attack even
>> more successful than it would otherwise have been (the kiddie
>> looks at effect on the host at the end).
>
> Then bug the driver author of your ethernet cards or turn the hammer off.
>  You're the sysadmin, you know that your system is unusual.  Deal with it.

The hammer has an average age of 13yrs and is difficult to turn off,
unfortunately.

Rather than bugging the author of the driver card, we've actually
been trying to fix it, down to rewriting the firmware. So for
this purpose I/we am/are the driver maintainer thanks. However,
there are limitations like bus speed which mean that in practice
if we receive a large enough number of small packets each second,
the box will saturate.

My point was merely that some applications (and using a linux
box as a router is not that 'unusual') want to deprioritize
different things under resource starvation. Changing the default,
in an unconfigurable way, isn't a great idea. Sure dealing
with external resource exhaustions for hosts is indeed a good
idea. I was just suggesting that it wasn't always what you
wanted to do.

Not sure this required jumping down my throat.

--
Alex Bligh
