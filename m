Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264433AbRFXTql>; Sun, 24 Jun 2001 15:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264432AbRFXTqc>; Sun, 24 Jun 2001 15:46:32 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:22021 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S264433AbRFXTqT>;
	Sun, 24 Jun 2001 15:46:19 -0400
Message-ID: <3B3643A8.F3FE1E92@bigfoot.com>
Date: Sun, 24 Jun 2001 13:46:48 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: klink@clouddancer.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Annoying kernel behaviour
In-Reply-To: <3B33EFC0.D9C930D5@bigfoot.com>    <9h0r6s$fe7$1@ns1.clouddancer.com>    <20010623090542.6019D7846F@mail.clouddancer.com> <3B35C2FA.37F57964@bigfoot.com> <9h4ft5$1ku$1@ns1.clouddancer.com> <20010624114655.3D187784C4@mail.clouddancer.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colonel wrote:
> Ah, notice that the IRQ shifted?  Perhaps there is something else on
> irq 10, such as the SCSI controller?  My video cards always end up on
> that IRQ, perhaps the computer is still accessible via the network?

I would expect the IRQ to shift as the system has a different
motherboard/processor than it did in December.


           CPU0       
  0:    3208074          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 10:          1          XT-PIC  bttv
 12:      10444          XT-PIC  eth0
 14:      12366          XT-PIC  ide0
 15:         67          XT-PIC  ide1
NMI:          0 
ERR:          0

There are no conflicts, and PCI should be able to share anyways.

That machine, being a server, is only accesible via the network.  And when
all my SSH sessions to it died, and the pings weren't pinging, I went over
to the server corner, attached a monitor to the machaine and tried the magic
sysrq on the keyboard after verifying that I couldn't get a local response. 
As I said, I can easily lock an entire system in a way that corrupts files
even on a synchronuslly mounted partition from userland with no warning, no
error messages.

Waht part of this do you fail to grasp?


--
    www.kuro5hin.org -- technology and culture, from the trenches.
