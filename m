Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270140AbRHMMTq>; Mon, 13 Aug 2001 08:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270138AbRHMMTg>; Mon, 13 Aug 2001 08:19:36 -0400
Received: from doninha.ip.pt ([195.23.132.12]:17934 "HELO doninha.ip.pt")
	by vger.kernel.org with SMTP id <S270135AbRHMMT1>;
	Mon, 13 Aug 2001 08:19:27 -0400
Message-ID: <20010813121933.4974.qmail@webmail.clix.pt>
X-Originating-IP: [198.62.9.29]
X-Mailer: Clix Webmail 2.0
In-Reply-To: <E15WGdk-0007H8-00@the-village.bc.nu>
In-Reply-To: <E15WGdk-0007H8-00@the-village.bc.nu> 
From: "rui.p.m.sousa@clix.pt" <rui.p.m.sousa@clix.pt>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds), pgallen@randomlogic.com,
        linux-kernel@vger.kernel.org
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Date: Mon, 13 Aug 2001 12:19:33 GMT
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:

>> Does the new driver not work for you? There seems to be a bug at close()
>> time, in that the driver uses "tasklet_unlock_wait()" instead of
>> "tasklet_kill()" to kill the tasklets, and that wouldn't work reliably.
> 
> It hung my SMP box solid
> It spews white noise on my box with surround speakers

Digital or analog speakers?

> And worked on the third
> 
> So I went back to the old one.
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/






--
Crie o seu Email Grátis no Clix em
http://registo.clix.pt/
