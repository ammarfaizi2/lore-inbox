Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVJMM0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVJMM0T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 08:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbVJMM0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 08:26:19 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:54553 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750971AbVJMM0S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 08:26:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kav48IqlV/h5OiO6GmVviUWV9jWRckqeXzkOzw6Cf4cytJyHgs2P/Ox2BFj+JMhvY9hcO1wK6KtafllqZHu86I7dAiVtaoBrmHz29KJUVu+Wsazgzd4ATIs27iB0rMjqX5z79d9unnN3/hoppGVESq9wM2BeD+XFieyr0AtEsjs=
Message-ID: <5bdc1c8b0510130526k6064c640pecded9ccb0ef7dde@mail.gmail.com>
Date: Thu, 13 Oct 2005 05:26:17 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc4-rt1 - enable IRQ-off tracing causes kernel to fault at boot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051013073029.GA12801@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510121000i5db112f2p642f66686fb46c57@mail.gmail.com>
	 <20051013073029.GA12801@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Mark Knecht <markknecht@gmail.com> wrote:
>
> > Config file attached. The only change was to enable IRQ-off latency
> > tracing using make menuconfig. Rebuild and reboot. I got a message
> > about the kernel not syncing, lots of stuff above that message about
> > do_futex, etc.
>
> i cannot reproduce your problems - your .config works fine on my x64
> box. A log of the crash would be needed - do you have a null-modem cable
> to connect this box to some other nearby box to do serial logging? If
> yes then there is a mini-howto below. (for x86, but it works the same
> for x64)
>
>         Ingo
>
>
Guitar player doesn't do serial ports? ;-)

OK, I've never done anything like this before, but I'm motivated so
I'll give it a shot. Hopefully I can make some headway without having
to ask too many stupid questions, such as the one that follows:

Question: Is a 'null modem' cable just a plain serial cable, or is it
a special serial cable I need to go buy?

Cheers,
Mark
