Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261469AbSIWVk2>; Mon, 23 Sep 2002 17:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261470AbSIWVk1>; Mon, 23 Sep 2002 17:40:27 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:52961 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261469AbSIWVkI>;
	Mon, 23 Sep 2002 17:40:08 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.35689.846139.896614@napali.hpl.hp.com>
Date: Mon, 23 Sep 2002 14:45:13 -0700
To: Daniel Phillips <phillips@arcor.de>
Cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, dmo@osdl.org, axboe@suse.de,
       _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
In-Reply-To: <E17tawV-0003cu-00@starship>
References: <15759.26918.381273.951266@napali.hpl.hp.com>
	<E17tanS-0003cl-00@starship>
	<15759.35002.179075.973994@napali.hpl.hp.com>
	<E17tawV-0003cu-00@starship>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 23 Sep 2002 23:40:35 +0200, Daniel Phillips <phillips@arcor.de> said:

  Daniel> Firm maybe.  The current driver does not attempt to do that
  Daniel> on ia32, and you're saying it should?  In that case should
  Daniel> the driver not have #define DAC_64, or similar?

I haven't looked at the complete driver, but yes, it probably needs to
have a #define DAC or its runtime-equivalent.

	--david
