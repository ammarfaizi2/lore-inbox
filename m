Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRJYMTr>; Thu, 25 Oct 2001 08:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRJYMTg>; Thu, 25 Oct 2001 08:19:36 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:63674 "EHLO
	garbo.localnet") by vger.kernel.org with ESMTP id <S272818AbRJYMTG>;
	Thu, 25 Oct 2001 08:19:06 -0400
Message-ID: <3BD80357.885628A3@canit.se>
Date: Thu, 25 Oct 2001 14:19:35 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: "'Gert-Jan Rodenburg'" <hertog@home.nl>, linux-kernel@vger.kernel.org
Subject: Re: Issue wit ACPI and Promise?
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6A7@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:

> The IDE controller is on irq 9 and I bet ACPI is, too. I've seen other
> reports like this.
>
> Either the ACPI interrupt handler is not sharing properly or the promise
> interrupt handler isn't. Given that I can't duplicate it, I'm reduced to
> waiting for some kind soul to send a patch.. :-(
>
> -- Andy
>

I also have a related problem with ACPI and emu10k driver both on IRQ 9 but
only when I run a SMP kernel.
My money is on that this is a problem with ACPI.



