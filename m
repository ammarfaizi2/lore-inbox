Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbRF2OaC>; Fri, 29 Jun 2001 10:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266094AbRF2O3w>; Fri, 29 Jun 2001 10:29:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39654 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266095AbRF2O3h>;
	Fri, 29 Jun 2001 10:29:37 -0400
Message-ID: <3B3C90F4.F068D314@mandrakesoft.com>
Date: Fri, 29 Jun 2001 10:30:12 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
In-Reply-To: <200106291410.HAA10170@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
>         I will put together patch to convert this to ugly but correct
> "if then; ... ; fi" statements later today if nobody has any better
> suggestions.

Don't dirty up the Config.in.  Define CONFIG_ARCH_xxx in various arches
where needed.

Some, like CONFIG_X86 for example, definitely needs to be declared in
arch/$arch/config.in in some places.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
