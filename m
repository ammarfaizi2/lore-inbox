Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbTHYF4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 01:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbTHYF4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 01:56:51 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:48004 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261499AbTHYF4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 01:56:50 -0400
Date: Mon, 25 Aug 2003 06:56:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: jim.houston@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030825055642.GF20529@mail.jlokier.co.uk>
References: <1061498486.3072.308.camel@new.localdomain> <16197.14968.235907.128727@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16197.14968.235907.128727@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
>  > The logic above is exactly what Intel says to do in "IA-32 Intel®
>  > Architecture Software Developer's Manual, Volume 2: Instruction Set
>  > Reference" on page 3-767.  It also says that sysenter was added to the
>  > Pentium II.
> 
> I double-checked AP-485 (24161823.pdf, the "real" reference to CPUID),
> and it says (section 3.4) that SEP is unsupported when the signature
> as a whole is less that 0x633. This means all PPros, and PII Model 3s
> with steppings less than 3.

So (double-checking) the pseudo-code in "IA-32: Intel Architecture
Software Development Manual, Volume 2: Instruction Set Reference" is buggy?

Oh my!  Perhaps there are other bugs in that behemoth of a manual, too :/

-- Jamie
