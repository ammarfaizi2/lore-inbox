Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289046AbSBXBI6>; Sat, 23 Feb 2002 20:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289053AbSBXBIs>; Sat, 23 Feb 2002 20:08:48 -0500
Received: from zero.tech9.net ([209.61.188.187]:16908 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289046AbSBXBIn>;
	Sat, 23 Feb 2002 20:08:43 -0500
Subject: Re: [PATCH] only irq-safe atomic ops
From: Robert Love <rml@tech9.net>
To: yodaiken@fsmlabs.com
Cc: Andrew Morton <akpm@zip.com.au>, Roman Zippel <zippel@linux-m68k.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020223180521.A5150@hq.fsmlabs.com>
In-Reply-To: <1014449389.1003.149.camel@phantasy>
	<3C774AC8.5E0848A2@zip.com.au> <20020223043815.B29874@hq.fsmlabs.com>
	<1014488408.846.806.camel@phantasy> <20020223120648.A1295@hq.fsmlabs.com>
	<3C781037.EA4ADEF5@linux-m68k.org> <3C781351.DCB40AD3@zip.com.au>
	<1014505987.1003.1104.camel@phantasy> <1014507951.850.1140.camel@phantasy>
	<3C782C34.2CC0E417@zip.com.au>  <20020223180521.A5150@hq.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 23 Feb 2002 20:08:43 -0500
Message-Id: <1014512924.1003.1225.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-02-23 at 20:05, yodaiken@fsmlabs.com wrote:

> Go for it! Only 900 odd calls to smp_processor_id in the kernel
> source last time I checked.

... and surprisingly few of them need explicit protection.

	Robert Love

