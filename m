Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHMI0>; Thu, 8 Feb 2001 07:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBHMIQ>; Thu, 8 Feb 2001 07:08:16 -0500
Received: from [202.212.27.182] ([202.212.27.182]:22024 "HELO antiopikon")
	by vger.kernel.org with SMTP id <S129031AbRBHMH7>;
	Thu, 8 Feb 2001 07:07:59 -0500
Date: Thu, 8 Feb 2001 21:08:01 +0900
From: Augustin Vidovic <vido@ldh.org>
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: Alan Cox <alan@redhat.com>, Andrey Savochkin <saw@saw.sw.com.sg>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
Message-ID: <20010208210801.A19394@ldh.org>
Reply-To: vido@ldh.org
In-Reply-To: <20010208204415.A19308@ldh.org> <Pine.LNX.4.30.0102080346150.31024-100000@age.cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0102080346150.31024-100000@age.cs.columbia.edu>; from ionut@cs.columbia.edu on Thu, Feb 08, 2001 at 03:53:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 03:53:10AM -0800, Ion Badulescu wrote:
> Still, there should be something before these suppressed messages started.

No, sorry, but absolutely nothing since the boot.

> It goes like this:
> 
> bit0 = 1 means the workaround may be omitted when operating at 10 Mbit
> bit1 = 1 means the workaround may be omitted when operating at 100 Mbit
> 
> So the workaround needs to be activated when at least one bit is zero, and 
> may be omitted when both bits are 1. That's exactly what the original code 
> does.

Ah ok.

> "Yesterday, a brick fell upon my head while I was walking on the street. 
> Today, I put my hat on before leaving home, and no brick fell on my head 
> anymore. So the hat must have helped!"

You're absolutely right. I still don't know if activating the workaround
helped, it just seemed to help.

> Please read the code if you don't believe me.

I read it, but I don't have the Intel docs, so I miss the information you
have.

Thank you for spending time for this problem.

-- 
Augustin Vidovic                   http://www.vidovic.org/augustin/
"Nous sommes tous quelque chose de naissance, musicien ou assassin,
 mais il faut apprendre le maniement de la harpe ou du couteau."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
