Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293289AbSCOVbD>; Fri, 15 Mar 2002 16:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293314AbSCOVax>; Fri, 15 Mar 2002 16:30:53 -0500
Received: from zero.tech9.net ([209.61.188.187]:19718 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293289AbSCOVak>;
	Fri, 15 Mar 2002 16:30:40 -0500
Subject: Re: [OOPS] Kernel powerdown
From: Robert Love <rml@tech9.net>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, andrew.grover@intel.com
In-Reply-To: <3C9264EC.CCCBEDD1@delusion.de>
In-Reply-To: <3C9264EC.CCCBEDD1@delusion.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 15 Mar 2002 16:30:41 -0500
Message-Id: <1016227843.1148.49.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, 2002-03-15 at 16:17, Udo A. Steinberg wrote:

> flushing ide devices: hda hdb hde 
> Power down.
> NMI Watchdog detected LOCKUP on CPU0

I suspect ACPI or whatever is not disabling the NMI watchdog on
shutdown.  The OOPS is harmless, but obviously does need to be fixed.

	Robert Love

