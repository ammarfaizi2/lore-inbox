Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281165AbRLVKzc>; Sat, 22 Dec 2001 05:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286759AbRLVKzX>; Sat, 22 Dec 2001 05:55:23 -0500
Received: from hermes.domdv.de ([193.102.202.1]:44039 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S281165AbRLVKzK>;
	Sat, 22 Dec 2001 05:55:10 -0500
Message-ID: <XFMail.20011222114206.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <1008992132.805.6.camel@thanatos>
Date: Sat, 22 Dec 2001 11:42:06 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Thomas Hood <jdthood@mail.com>
Subject: Re: APM driver patch summary
Cc: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>, rmk@arm.linux.org.uk,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll have a look over the weekend.

On 22-Dec-2001 Thomas Hood wrote:
> I wrote:
> ---------------------------------------------------------------------
> Here is an updated list of the patches:
> 1. Notify listener of suspend before drivers        (Russell King, me)
>     (appended)
> 2. Fix idle handling                                (Andreas Steinmetz)
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=100754277600661&w=2
> 3. Control apm idle calling by runtime parameter    (Andrej Borsenkow)
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=100852862320955&w=2
> 4. Detect failure to stop CPU on apm idle call      (Andrej Borsenkow)
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=100869841008117&w=2
> ---------------------------------------------------------------------
> 
> I have just tried to combine these and I have run into trouble.
> Patch 4 applies on top of patch 3, but neither of these applies
> on top of patch 2.  Can you guys sort these out into one big
> "fix idle calling" patch that includes a runtime parameter
> to control idle calling, which overrides a default selected
> either by CONFIG_APM_CPU_IDLE or by a bit of code that checks
> for CPU stoppage?
> 
> Or has someone already done this?
> 
> The latest Russell King (modified by me) patch is now at:
>    http://panopticon.csustan.edu/thood/apm.html
> 
> --
> Thomas Hood
> 
> 
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
