Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131750AbQLVDak>; Thu, 21 Dec 2000 22:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131755AbQLVDab>; Thu, 21 Dec 2000 22:30:31 -0500
Received: from [204.244.205.25] ([204.244.205.25]:8552 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S131750AbQLVDaV>;
	Thu, 21 Dec 2000 22:30:21 -0500
From: Michael Peddemors <michael@linuxmagic.com>
Organization: Wizard Internet Services
To: Mike OConnor <kernel@pineview.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No more DoS
Date: Thu, 21 Dec 2000 20:09:27 -0800
X-Mailer: KMail [version 1.1.95.0]
Content-Type: text/plain
In-Reply-To: <977453684.3a42c2744fbb7@ppro.pineview.net>
In-Reply-To: <977453684.3a42c2744fbb7@ppro.pineview.net>
Cc: netfilter-devel@us5.samba.org
MIME-Version: 1.0
Message-Id: <0012212009271E.24471@mistress>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not only is this a well written article, and clearer than most other 
documents (Even Mine :>) but he is dead on track with his basic concepts..
Exactly what I have been looking into over at our company. (Well, close 
enough)

The concept of trusting a SYN packet, has to go.. we have to assume that it 
is false/bad, and only after receiving the ACK in reply to our SYN/ACK can we 
start assuming that the previous packets were good.. 

All IMHO....   Nice find and a good read for anyone..

I am CC'ing the netfilter list as they might like the read.. in case they 
haven't read it.  (Surprised I haven't seen more discussion on this topic)

On Thu, 21 Dec 2000, Mike OConnor wrote:
> Hi
>
> I would like to point who ever is in charge of the TCP stack for the linux
> kernel at a site which claims to have a method of eliminate denial of
> service (DoS) attacks
>
> http://grc.com/r&d/nomoredos.htm
>
> With my limited unstanding of TCP and DoS attacks this would seem to be the
> answer, instead of a work around.
>

-- 
--------------------------------------------------------
Michael Peddemors - Senior Consultant
Unix Administration - WebSite Hosting
Network Services - Programming
Wizard Internet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604) 589-0037 Beautiful British Columbia, Canada
--------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
