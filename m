Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272950AbRIMJXu>; Thu, 13 Sep 2001 05:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272946AbRIMJXl>; Thu, 13 Sep 2001 05:23:41 -0400
Received: from mx9.port.ru ([194.67.57.19]:34472 "EHLO mx9.port.ru")
	by vger.kernel.org with ESMTP id <S272951AbRIMJXX>;
	Thu, 13 Sep 2001 05:23:23 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109131345.f8DDj9c30736@vegae.deep.net>
Subject: Re: OOPS handling proposal
To: adilger@turbolabs.com (Andreas Dilger)
Date: Thu, 13 Sep 2001 13:45:09 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010913001218.E1541@turbolinux.com> from "Andreas Dilger" at Sep 13, 2001 12:12:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Andreas Dilger wrote:"
> 
> On Sep 13, 2001  06:11 +0000, Samium Gromoff wrote:
> >         Hello folks!
> >     People most likely needs first oops most of the time, so
> >   it would be great to make a kernel boot option to stop after
> >   first oops, so in the situations when its neede life can be made easy.
> >     Actually afaics this is being done each time by hand, so 
> >   panic() in BUG() as Rik proposed would be nice.
> >     What do you folks think?
> 
> Absolutely NOT.  If you panic() in BUG() then you DO have to copy the oops
> by hand each time, whereas the normal situation is that you can keep
> running after an oops - to decode it, see what the symptoms are, check
> memory, etc.
   Hmm... I propose to make it a boot option.
   Else sometimes you wont be able to retrieve info at all, as like
 in the situation i have right now: oops in kupdated which i even
 cant post and it remains there all 2.4.8 and 2.4.9.

Cheers, Sam

