Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131020AbRCMKFC>; Tue, 13 Mar 2001 05:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131027AbRCMKEn>; Tue, 13 Mar 2001 05:04:43 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9873 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131020AbRCMKEV>;
	Tue, 13 Mar 2001 05:04:21 -0500
Message-ID: <3AADF069.7B22EF1F@mandrakesoft.com>
Date: Tue, 13 Mar 2001 05:03:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Cc: Linux Knernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: Modular versus non-modular ISAPNP
In-Reply-To: <200103130403.f2D43Kh10666@moisil.dev.hydraweb.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> On Mon, 12 Mar 2001 22:02:12 -0500, Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> 
> > It is highly recommended to always compile with CONFIG_ISAPNP=y due to
> > these differences.  If you grep around for CONFIG_ISAPNP versus
> > CONFIG_ISAPNP_MODULE, you'll see that many drivers are woefully
> > unprepared for isapnp support compiled as a module.
> 
> Another entry for the Kernel Janitor's List, perhaps?

Yep..  grep for CONFIG_ISAPNP, look at the code, and evaluate it to make
sure that isapnp works for that drivers regardless of whether
CONFIG_ISAPNP -or- CONFIG_ISAPNP_MODULE is defined.

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
