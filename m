Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313312AbSDYQsS>; Thu, 25 Apr 2002 12:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313330AbSDYQsR>; Thu, 25 Apr 2002 12:48:17 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:4827 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313312AbSDYQsQ>;
	Thu, 25 Apr 2002 12:48:16 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15560.13127.882861.459400@napali.hpl.hp.com>
Date: Thu, 25 Apr 2002 09:48:07 -0700
To: Steven Cole <elenstev@mesatop.com>
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.9-dj1, move choice selection in arch/ia64/config.in.
In-Reply-To: <1019751391.2540.26.camel@spc9.esa.lanl.gov>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 25 Apr 2002 10:16:31 -0600, Steven Cole <elenstev@mesatop.com> said:

  Steven> This patch moves the choice selection for Physical memory
  Steven> granularity from the "Kernel hacking" section to the
  Steven> "Processor type and features" section right after the
  Steven> choices for IA-64 processor type, IA-64 system type, and
  Steven> Kernel page size.  This seems to be a less obscure place for
  Steven> this option.

Please don't move around stuff that you may not understand.  This
option is *meant* to be in an obscure place, because, frankly, it's an
obscure thing that most folks never have to worry about.  It's only
needed for certain, very rare, machines and it's only a temporary
thing.

Thanks,

	--david
