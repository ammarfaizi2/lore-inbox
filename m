Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262347AbRERPUD>; Fri, 18 May 2001 11:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbRERPTx>; Fri, 18 May 2001 11:19:53 -0400
Received: from t2.redhat.com ([199.183.24.243]:48891 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S262341AbRERPTo>; Fri, 18 May 2001 11:19:44 -0400
Message-ID: <3B053D8A.FF16ECEC@redhat.com>
Date: Fri, 18 May 2001 16:19:38 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <20010518105353.A13684@thyrsus.com> <1694.990198581@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

> >   (c) Decide not to support this case and document the fact in the
> >       rulesfile.  If you're going put gunge on the VME bus that replaces
> >       the SBC's on-board facilities, you can hand-hack your own configs.
> 
> In general this is the best option, if you create a non-standard
> configuration for machine foo then it is your problem, not everybody
> else's.

If you use a standard configuration, you can use a precompiled 
kernel as well.

Sorry I don't buy this. The point of the kernel configuration 
is to also allow non-standard configurations. Think about it:
the standard pc (PC99 or whatever it is called this year) doesn't
have a PS/2 port, only USB. So we can remove even the question 
from the config system, no? 

Greetings,
   Arjan van de Ven
