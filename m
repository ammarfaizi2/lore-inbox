Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbTJGRz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 13:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbTJGRz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 13:55:26 -0400
Received: from relay.pair.com ([209.68.1.20]:50959 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S262555AbTJGRzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 13:55:21 -0400
X-pair-Authenticated: 68.42.66.6
Subject: Re: More 2.6.0-test6 PCMCIA and Orinoco problems
From: Daniel Gryniewicz <dang@fprintf.net>
To: "Joshua M. Thompson" <funaho@jurai.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1065540880.1415.22.camel@lumiere.jurai.org>
References: <1065540880.1415.22.camel@lumiere.jurai.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1065549318.4323.9.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 07 Oct 2003 13:55:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-07 at 11:34, Joshua M. Thompson wrote:
> Been searching the net and list archives for a three days now and can't
> find any reports of this exact problem, so here goes:
> 
> I finally decided to try out 2.6 on my notebook again. It's a Gateway
> 600E (P4-M 2.0, Intel 845 chipset, TI PCI1250 cardbus controller)
> running RedHat 9.0, upgraded with the beta RPMS from
> http://people.redhat.com/arjanv/2.5/. I'm up and running MOSTLY ok
> except that I can't get PCMCIA to work. Specifically, my built-in
> Orinoco wireless card doesn't work anymore, nor does an Orinoco Gold
> card I happen to have lying around. PCMCIA starts up ok and the
> orinoco_cs driver loads; however it fails to start, giving only the
> error message "ds: unable to create instance of 'orinoco_cs'".
> 
> I've tried several solutions. Tried booting with ACPI off, with APIC
> off, and even tried "cardctl eject; cardctl insert" which seems to help
> some people. Same error every time. The wireless card works fine with
> 2.4.20 and also worked fine when I briefly tried 2.5.68 a while back.

<snip>

Is this the in-kernel driver or the one from pcmcia-cs?  I use the
in-kernel driver and pcmcia socket driver (yenta), and just use the
userspace tools from pcmcia-cs, and everything is good for me.  I never
was able to get a pure pcmcia-cs (userspace and drivers) working with my
2.6.0-test1 kernels when I tried it.

-- 
Daniel Gryniewicz <dang@fprintf.net>
