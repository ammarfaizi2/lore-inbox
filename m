Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbRFMNWI>; Wed, 13 Jun 2001 09:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbRFMNVs>; Wed, 13 Jun 2001 09:21:48 -0400
Received: from t2.redhat.com ([199.183.24.243]:3574 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S262076AbRFMNVi>; Wed, 13 Jun 2001 09:21:38 -0400
Message-ID: <3B2768E1.2B7E064C@redhat.com>
Date: Wed, 13 Jun 2001 14:21:37 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-11.3smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sven Geggus <geg@iitb.fhg.de>, linux-kernel@vger.kernel.org
Subject: Re: Changing CPU Speed while running Linux
In-Reply-To: <20010613143536.A1323@iitb.fhg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Geggus wrote:
> 
> Hi there,
> 
> on my Elan410 based System it is very easy to change the CPU clock speed by
> means od two outb commands.
> 
> I was wondering, if it does some harm to the Kernel if the CPU is
> reprogrammed using a different CPU clock speed, while the system is up and
> running.

I have a module for the K6 PowerNow which allows you to do

echo 450 > /proc/sys/cpu/0/frequency

and does the right thing wrt udelay / bogomips etc..
I can dig it out if you want.. sounds like this should be a more generic
thing.

Greetings,
  Arjan van de Ven
