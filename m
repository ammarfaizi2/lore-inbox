Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLPBLm>; Fri, 15 Dec 2000 20:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQLPBLd>; Fri, 15 Dec 2000 20:11:33 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:51209 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129340AbQLPBLM>; Fri, 15 Dec 2000 20:11:12 -0500
Message-ID: <3A3AB9FD.B58049C4@mvista.com>
Date: Fri, 15 Dec 2000 16:40:29 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <200012141308.eBED8Oh06198@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Rogier Wolff writes:
> > Alan Cox wrote:
> > > What better interactivity ;)
> > Thus to me, 2.4 FEELS much less interactive. When I move windows they
> > don't follow the mouse in real-time.
> 
> Interesting observation: in a scrolling rxvt, kernel 2.0 is smoother than
> 2.2, which is smoother than 2.4.  I hope this trend isn't going to
> continue to 2.6. ;(

Could this be due to the shorter times caculated by the scheduler
recaculate code with the change that moved "nice" into the task_struct? 

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
