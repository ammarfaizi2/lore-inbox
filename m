Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272182AbRH3MYb>; Thu, 30 Aug 2001 08:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272184AbRH3MYV>; Thu, 30 Aug 2001 08:24:21 -0400
Received: from zeke.inet.com ([199.171.211.198]:7405 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S272182AbRH3MYI>;
	Thu, 30 Aug 2001 08:24:08 -0400
Message-ID: <3B8E2F44.7BCC1920@inet.com>
Date: Thu, 30 Aug 2001 07:19:16 -0500
From: "Jordan Breeding" <jordan.breeding@inet.com>
Reply-To: Jordan <ledzep37@home.com>,
        Jordan Breeding <jordan.breeding@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: Jordan <ledzep37@home.com>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Having problems with 2.4.9-ac
In-Reply-To: <200108301216.OAA03980@nbd.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> "A month of sundays ago Jordan Breeding wrote:"
> > I have reported having problems shuting down and rebooting my SMP
> > machine before.  Before the 2.4.8/9 series or ac kernels the last kernel
> 
> ditto.
> 
> > correctly reboot or shut down anymore.  What might the problem be?  I
> > don't want to go back to 2.4.8-ac10 if at all possible, 2.4.9-ac3 is one
> > of if not the most stable 2.4 kernel I have run in a long time.  Thank
> 
> Does anyone have the patch diff from 8-ac10 to 8-ac11 in the apm area?
> This sounds very hopeful for tracking down the problem .. if it's not
> just timing.
> 
> Peter

I don't think that it has anything to do with APM specifically.  On the
kernel which it doesn't work on I can use nothing, ACPI, or APM (with
smp power-off set to on).  On the kernel revisions for which it works I
normally just use ACPI.  I don't like to use APM since it isn't smp
clean completely and I only use ACPI for power-off and reboot options so
I normally just stick with that.  I guess it could be APM which is
broken but then why would ACPI not work for simple rebooting and
shutting down all the time?

Jordan
