Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUADAop (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUADAop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:44:45 -0500
Received: from hell.org.pl ([212.244.218.42]:28426 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264365AbUADAoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:44:44 -0500
Date: Sun, 4 Jan 2004 01:44:49 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [2.6.0-mm2] PM timer still has problems
Message-ID: <20040104004449.GA20647@hell.org.pl>
References: <20031230204831.GA17344@hell.org.pl> <20031230200249.107b56f0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20031230200249.107b56f0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Andrew Morton:
> >  Booting with clock=pmtmr causes weird problems here (the system 
> >  complains that clock override failed and the bogomips loop produces bogus
> >  values). Below is the dmesg output as well as /proc/cpuinfo.
> >  I have CONFIG_X86_LOCAL_APIC=y and CONFIG_X86_PM_TIMER=y.
> Yup, thanks.  Several people have reported problems with the PM timer. 
> Unfortunately, everyone's symptoms seem to be different.

Just for the record: I'm still getting those problems with 2.6.1-rc1-mm1.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
