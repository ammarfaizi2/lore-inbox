Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUDLUca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 16:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUDLUca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 16:32:30 -0400
Received: from palrel13.hp.com ([156.153.255.238]:40628 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263059AbUDLUc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 16:32:29 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16506.64729.917048.491827@napali.hpl.hp.com>
Date: Mon, 12 Apr 2004 13:32:25 -0700
To: dl8bcu@dl8bcu.de
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, rth@twiddle.net,
       spyro@f2s.com, rmk@arm.linux.org.uk, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [1/3]
In-Reply-To: <20040412200835.A5625@Marvin.DL8BCU.ampr.org>
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
	<20040412075704.B5198@Marvin.DL8BCU.ampr.org>
	<16506.50767.128817.828166@napali.hpl.hp.com>
	<20040412200835.A5625@Marvin.DL8BCU.ampr.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 12 Apr 2004 20:08:36 +0000, Thorsten Kranzkowski <dl8bcu@dl8bcu.de> said:

  Thorsten> So I thought an architectural define was
  Thorsten> appropriate. Maybe timex.h is not the best place to put it
  Thorsten> in.

Yes, a #define is probably needed, but I do think timex.h is the wrong
place.  Perhaps <asm/8253pit.h> along with a suitable CONFIG_8253PIT
Kconfig option?

	--david
