Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRCUDKy>; Tue, 20 Mar 2001 22:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131140AbRCUDKn>; Tue, 20 Mar 2001 22:10:43 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:61476 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131063AbRCUDKj>; Tue, 20 Mar 2001 22:10:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jeff Lightfoot <jeffml@pobox.com>
Reply-To: jeffml@pobox.com
To: jgarzik@mandrakesoft.com (Jeff Garzik), "Manuel A. McLure" <mmt@unify.com>
Subject: Re: NETDEV WATCHDOG: eth0: transmit timed out on LNE100TX 4.0, kernel2.4.2-ac11 and earlier.
Date: Tue, 20 Mar 2001 20:09:45 -0700
X-Mailer: KMail [version 1.2]
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C134@pcmailsrv1.sac.unify.com> <3AB7CFF1.FFC17E31@mandrakesoft.com>
In-Reply-To: <3AB7CFF1.FFC17E31@mandrakesoft.com>
MIME-Version: 1.0
Message-Id: <01032020094500.03835@earth>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 March 2001 14:58, Jeff Garzik wrote:
> > With all the above kernel revisions/drivers, my network card
> > hangs at random (sometimes within minutes, other times it takes
> > days). To restart it I need to do an ifdown/ifup cycle and it
> > will work fine until the next hang. I upgraded to 2.4.2-ac11
> > because of the documented tulip fixes, but after a few days got
> > this again. The error log shows:
>
> In Alan Cox terms, that's a long time ago :)
>
> Can you please try 2.4.2-ac20?  It includes fixes specifically for
> this problem.

I started having the same problem with my LNE100TX and switched it 
out with another LNE100TX and had the same problem.  Figured it was 
my BP6 SMP motherboard and ordered a new computer. Doh. :-)

Using 2.4.2-ac20.
Current LNE100TX having problems (other is different Rev):
  Lite-On Communications Inc LNE100TX (rev 20)

The first card would get "unexpected IRQ trap at vector d0" before 
dying whereas the second one didn't give that indication.  It would 
just freeze and the traditional "NETDEV WATCHDOG: eth0: transmit 
timed out" message.
