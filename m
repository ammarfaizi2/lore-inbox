Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbSKSQi4>; Tue, 19 Nov 2002 11:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbSKSQi4>; Tue, 19 Nov 2002 11:38:56 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5357 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264872AbSKSQiz>; Tue, 19 Nov 2002 11:38:55 -0500
Date: Tue, 19 Nov 2002 17:45:50 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Ducrot Bruno <poup@poupinou.org>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
Message-ID: <20021119164550.GQ11952@fs.tum.de>
References: <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com> <20021119130728.GA28759@suse.de> <20021119142731.GF27595@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119142731.GF27595@poup.poupinou.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 03:27:31PM +0100, Ducrot Bruno wrote:

>...
> I disagree with you.  It introduces more enhancements,
> and more bugfix than the current code.  I admit that tt
> could introduce some news bugs, but in the balance it
> should be more stable than before.
>...

It's not "in the balance". 2.4 is a stable kernel series. The problem is
that if you switch from one stable kernel series to another
(e.g. 2.2 -> 2.4) on a production machine you know that you have to
check whether everything works as before you upgrade your production
machines. This can take quite some time. Within a stable kernel series
everything that worked in earlier kernels within this series should work
in future kernels in this kernel series. Don't forget that e.g. a
fixed security problem might force people to do a quick upgrade of
production machines to the latest kernel in this series.

There's always the possibility that you apply patches or use one of the
many two-to-four-letter patches which might contain the patch you
need.

Note: I don't know the specific situation with the new ACPI code and
      whether it might be good to include it, my arguments are an
      answer to your "in the balance" argument.

> Cheers,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

