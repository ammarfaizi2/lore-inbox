Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270023AbRHQOeW>; Fri, 17 Aug 2001 10:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269350AbRHQOeO>; Fri, 17 Aug 2001 10:34:14 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:58076 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S269237AbRHQOeA>;
	Fri, 17 Aug 2001 10:34:00 -0400
Date: Fri, 17 Aug 2001 15:34:07 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Robert Love <rml@tech9.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] Optionally let Net Devices feed Entropy
Message-ID: <1991620468.998062447@[10.132.112.53]>
In-Reply-To: <998009275.664.67.camel@phantasy>
In-Reply-To: <998009275.664.67.camel@phantasy>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> now, we talked earlier about this patch, Alex -- what are your opinions
> of it?  have you tried it?
>
> i know it is not exactly what you want (although i am still open to your
> way, too), but i made it due in no small part to our conversation and
> would like your opinion.  i am using it now.

Looks 'obviously correct' to me (famous last words). I can't try it
on the system that is otherwise entropy-short as I don't want to
touch the kernel on that box right now.

As I said to you by private email, I have a slight preference for
a /proc controlled version (just so vendor-distributed precompiled
kernels could work either way, with the vendor-dist rc script
chosing a default option based on the vendor config script) given
coding /proc entries is trivial (see manual patch :-). However, your
patch is many many times better than the status quo IMHO.

--
Alex Bligh
