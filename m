Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbUADQdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265734AbUADQdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:33:15 -0500
Received: from [130.57.169.10] ([130.57.169.10]:42168 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S265726AbUADQdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:33:14 -0500
Subject: Re: Pentium M config option for 2.6
From: Rob Love <rml@ximian.com>
To: Dave Jones <davej@redhat.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, szepe@pinerecords.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040104162516.GB31585@redhat.com>
References: <200401041227.i04CReNI004912@harpo.it.uu.se>
	 <1073228608.2717.39.camel@fur>  <20040104162516.GB31585@redhat.com>
Content-Type: text/plain
Message-Id: <1073233988.5225.9.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 04 Jan 2004 11:33:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-04 at 11:25, Dave Jones wrote:

> Regardless, Tomas's patch changed CONFIG_X86_L1_CACHE_SHIFT for
> that CPU, and CONFIG_X86_L1_CACHE_SHIFT shouldn't affect this.
> The cacheline size is determined at boottime using the code in
> pcibios_init() and set using pci_generic_prep_mwi().
> 
> The config option is the default that pci_cache_line_size starts at,
> but this gets overridden when the CPU type is determined.

Yah.  I was just answering in the abstract to the "does cache line
matter on non-SMP" question.

I actually like this patch (perhaps since I have a P-M :) and think it
ought to go in, although I agree with others that the P-M is more of a
super-P3 than a scaled down P4.

	Rob Love


