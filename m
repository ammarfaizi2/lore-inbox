Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbTFBM2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTFBM2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:28:00 -0400
Received: from holomorphy.com ([66.224.33.161]:39838 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262270AbTFBM1w (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:27:52 -0400
Date: Mon, 2 Jun 2003 05:40:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Gianni Tedesco <gianni@scaramanga.co.uk>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Linus Torvalds <Torvalds@Transmeta.COM>, Andrew Morton <AKPM@Digeo.COM>
Subject: Re: const from include/asm-i386/byteorder.h
Message-ID: <20030602124016.GP8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Gianni Tedesco <gianni@scaramanga.co.uk>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
	Linus Torvalds <Torvalds@Transmeta.COM>,
	Andrew Morton <AKPM@Digeo.COM>
References: <16088.47088.814881.791196@laputa.namesys.com> <1054406992.4837.0.camel@sherbert> <20030531185709.GK8978@holomorphy.com> <16091.14923.815819.792026@laputa.namesys.com> <20030602121457.GO8978@holomorphy.com> <16091.17602.257293.364468@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16091.17602.257293.364468@laputa.namesys.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>> Someone needs to doublecheck whether this actually works. Last I heard,

On Mon, Jun 02, 2003 at 04:36:18PM +0400, Nikita Danilov wrote:
> I don't quite understand. __attribute_const is defined as
> #define __attribute_const __attribute__ ((__const__))
> so, after preprocessing prototypes of get_current() and
> current_thread_info() will be the same as before patch, modulo spacing.

William Lee Irwin III writes:
>> it did not, but that could have changed since. It vaguely appears some
>> assumption about it working was made recently since __const__ was there.

On Mon, Jun 02, 2003 at 04:36:18PM +0400, Nikita Danilov wrote:
> I am currently running ./fsstress -p 111 on patched kernel on 2*XEON
> 2.20GHz with hyper threading.

Sounds good. If you could doublecheck the assembly to make sure it's
doing the right thing, that would be good, too.

Thanks.

-- wli
