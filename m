Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264965AbRGFExv>; Fri, 6 Jul 2001 00:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265969AbRGFExl>; Fri, 6 Jul 2001 00:53:41 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62908 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264965AbRGFExY>;
	Fri, 6 Jul 2001 00:53:24 -0400
Message-ID: <3B45443C.32ADA7F@mandrakesoft.com>
Date: Fri, 06 Jul 2001 00:53:16 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trevor Hemsley <Trevor-Hemsley@dial.pipex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcmcia lockup inserting or removing cards in 2.4.5-ac{13,22}
In-Reply-To: <20010705220051Z264475-17720+11254@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trevor Hemsley wrote:
> 
> On Thu, 5 Jul 2001 03:06:11, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
> wrote:
> 
> > Hmm, Cardbus and USB problems... you probably have both Cardbus and
> > i82365 support in your kernel configuration.
> 
> Once I have the BIOS set to "cardbus/16 bit" instead of "auto-detect"
> I don't have a problem with having both Cardbus and i82365 support
> compiled in. If the BIOS is set to auto then the PCI tables don't have
> an IRQ specified and yenta.c uses IRQ 0!

Interesting...   That sounds like the kernel's plug-n-play code isn't
doing its job.

-- 
Jeff Garzik      | Thalidomide, eh? 
Building 1024    | So you're saying the eggplant has an accomplice?
MandrakeSoft     |
