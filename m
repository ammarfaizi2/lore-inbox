Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbRFQPIi>; Sun, 17 Jun 2001 11:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264740AbRFQPI2>; Sun, 17 Jun 2001 11:08:28 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63709 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264739AbRFQPIT>;
	Sun, 17 Jun 2001 11:08:19 -0400
Message-ID: <3B2CC7DC.EEAF3253@mandrakesoft.com>
Date: Sun, 17 Jun 2001 11:08:12 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: rjd@xyzzy.clara.co.uk, Bill Pringlemeir <bpringle@sympatico.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Newbie idiotic questions.
In-Reply-To: <200106171227.f5HCRZu10829@xyzzy.clara.co.uk> <0106171701100P.00879@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Yep, the only thing left to resolve is whether Jeff had coffee or not. ;-)
> 
> -       if ((card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout), GFP_KERNEL))
> +       if ((card->mpuout = kmalloc(sizeof(*card->mpuout), GFP_KERNEL))

Yeah, this is fine.  The original posted omitted the '*' which was not
fine :)

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
