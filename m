Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbRGSOmS>; Thu, 19 Jul 2001 10:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267578AbRGSOmI>; Thu, 19 Jul 2001 10:42:08 -0400
Received: from 194.38.82.urbanet.ch ([194.38.82.193]:55050 "EHLO
	internet.dapsys.com") by vger.kernel.org with ESMTP
	id <S267577AbRGSOlz> convert rfc822-to-8bit; Thu, 19 Jul 2001 10:41:55 -0400
From: Edouard Soriano <e_soriano@dapsys.com>
Date: Thu, 19 Jul 2001 14:39:37 GMT
Message-ID: <20010719.14393700@dap21.dapsys.ch>
Subject: 1GB system working with 64MB
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello Folks,

Environment: linux 2.2.16smp
RedHat 7.0

I am setting up a system with 1GB RAM recongized by the
BIOS during power-on procedure.

This system having troubles, I set a top command and
with surprise I got this  status:

  4:33pm  up  4:42,  3 users,  load average: 4.18, 2.01, 1.09
125 processes: 123 sleeping, 2 running, 0 zombie, 0 stopped
CPU0 states:  9.1% user,  9.0% system,  8.0% nice, 80.1% idle
CPU1 states: 20.0% user,  6.1% system, 20.1% nice, 72.0% idle
Mem:    63892K av,   62480K used,    1412K free,   15076K shrd,    5192K 
buff
Swap:  514040K av,  260556K used,  253484K free                   11804K 
cached

My problem are the 63892K

I remember there is a solution to turn around this problem
forcing LILO to configure 1GB saying, I think but not 
sure:

append='memory=1024'

I searched in the lilo doc for memory parameter definition, but
as being coverd by append parameter I found nothing.

Question 1:
Do you have an idea about the reason Linux is using 64MB ?

Question 2:
Is this append command correct to turn out this problem ?

Question 3:
Where can I found informations about append variables wich
are related in fact with modules parameters ?
How to find on source code which module will read the 
memory parameter ?

Thanks in advance.

Bye
 
