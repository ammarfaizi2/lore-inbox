Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261736AbSIXSWV>; Tue, 24 Sep 2002 14:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261743AbSIXSWU>; Tue, 24 Sep 2002 14:22:20 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:16320 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261736AbSIXSWS>;
	Tue, 24 Sep 2002 14:22:18 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15760.44685.440396.2440@napali.hpl.hp.com>
Date: Tue, 24 Sep 2002 11:27:25 -0700
To: Daniel Phillips <phillips@arcor.de>
Cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Dave Olien <dmo@osdl.org>, "David S. Miller" <davem@redhat.com>,
       axboe@suse.de, _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
In-Reply-To: <E17ttpe-0003ii-00@starship>
References: <20020923120400.A15452@acpi.pdx.osdl.net>
	<20020924095456.A17658@acpi.pdx.osdl.net>
	<15760.40126.378814.639307@napali.hpl.hp.com>
	<E17ttpe-0003ii-00@starship>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 24 Sep 2002 19:50:46 +0200, Daniel Phillips <phillips@arcor.de> said:

  Daniel> On Tuesday 24 September 2002 19:11, David Mosberger wrote:
  >> (and just
  >> in case Dave Miller starts asking about this: yes, the hp zx1 chipset
  >> for Itanium 2 does have a hardware I/O TLB... ;-).

  Daniel> Excuse me, could you please elaborate on the significance of this
  Daniel> for the rest of us? ;-)

Sorry, I didn't mean to be cryptic and it's really nothing deep.  It's
just that in the past Dave Miller used, let's say, "colorful" language
whenever someone mentioned the fact that the original Itanium machines
didn't have a hardware I/O TLB.  The new Itanium 2 machines from hp
have a chipset with heritage from pa-risc, so they don't have this
limitation (to be fair to Intel though, I don't think the lack of a hw
I/O TLB is a huge issue anymore, given that nowadays you can readily
find all kinds of PCI controllers that support DAC, including network
adapters).

	--david
