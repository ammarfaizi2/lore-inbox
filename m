Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSIWUp6>; Mon, 23 Sep 2002 16:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbSIWUp6>; Mon, 23 Sep 2002 16:45:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12987 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261375AbSIWUp5>;
	Mon, 23 Sep 2002 16:45:57 -0400
Date: Mon, 23 Sep 2002 13:40:00 -0700 (PDT)
Message-Id: <20020923.134000.123546377.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: dmo@osdl.org, axboe@suse.de, phillips@arcor.de, _deepfire@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15759.26918.381273.951266@napali.hpl.hp.com>
References: <20020923120400.A15452@acpi.pdx.osdl.net>
	<15759.26918.381273.951266@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Mon, 23 Sep 2002 12:19:02 -0700
   
   This looks like a porting-nightmare in the making.  There's got to be a
   better way to determine whether you need a writeq() vs. a writel().

Or perhaps every platform should provide a writeq(), on 32-bit systems
it may merely be implemented as two consequetive writel() calls.
