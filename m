Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131353AbRAaApB>; Tue, 30 Jan 2001 19:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131496AbRAaAov>; Tue, 30 Jan 2001 19:44:51 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:11792 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S131353AbRAaAod>; Tue, 30 Jan 2001 19:44:33 -0500
Message-ID: <3A775FEB.D7614D98@Hell.WH8.TU-Dresden.De>
Date: Wed, 31 Jan 2001 01:44:27 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Request: increase in PCI bus limit
In-Reply-To: <200101310008.f0V08Wv23250@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Neufeld wrote:

>  The only patch
> which has to be applied to make Linux run stably on these systems is to
> increase that limit.  Would it be possible to bump it up to 128, or even
> 256, in later 2.4.* kernel releases?  That would allow this customer to
> work with an unpatched kernel, at the cost of an additional 3.5 kB of
> variables in the kernel.

I guess the cleanest solution would be to allow variable setting of the
maximum number of PCI busses in the config file, similar to the
CONFIG_UNIX98_PTY_COUNT setting, so that "exotic" users with 32+ PCI
busses can boost the standard value according to their needs, without
having to increase kernel size for the normal users.

Regards,
Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
