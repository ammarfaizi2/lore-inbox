Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266104AbTLaECd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 23:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266105AbTLaECb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 23:02:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:19384 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266104AbTLaECb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 23:02:31 -0500
Date: Tue, 30 Dec 2003 20:02:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [2.6.0-mm2] PM timer still has problems
Message-Id: <20031230200249.107b56f0.akpm@osdl.org>
In-Reply-To: <20031230204831.GA17344@hell.org.pl>
References: <20031230204831.GA17344@hell.org.pl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karol Kozimor <sziwan@hell.org.pl> wrote:
>
>  Booting with clock=pmtmr causes weird problems here (the system 
>  complains that clock override failed and the bogomips loop produces bogus
>  values). Below is the dmesg output as well as /proc/cpuinfo.
>  I have CONFIG_X86_LOCAL_APIC=y and CONFIG_X86_PM_TIMER=y.

Yup, thanks.  Several people have reported problems with the PM timer. 
Unfortunately, everyone's symptoms seem to be different.

I'm not sure whether we're dealing with BIOS problem, hardware problems, an
implementation bug or all of the above.

Arjan, was the PM time code in 2.4 widely deployed and/or reliable?

