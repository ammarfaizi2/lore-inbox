Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVCVOCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVCVOCC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 09:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVCVOCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 09:02:02 -0500
Received: from [81.2.110.250] ([81.2.110.250]:17372 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261251AbVCVN7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 08:59:46 -0500
Subject: Re: mouse&keyboard with 2.6.10+
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, mjt@tls.msk.ru,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050322074435.GC3360@ucw.cz>
References: <4235683E.1020403@tls.msk.ru> <42357AE0.4050805@tls.msk.ru>
	 <20050314142847.GA4001@ucw.cz> <4235B367.3000506@tls.msk.ru>
	 <20050314162537.GA2716@ucw.cz> <4235BDFD.1070505@tls.msk.ru>
	 <20050314164342.GA1735@ucw.cz> <20050321172411.247e32b6.akpm@osdl.org>
	 <20050322074435.GC3360@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111499816.14833.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 22 Mar 2005 13:56:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-03-22 at 07:44, Vojtech Pavlik wrote:
> Not yet. There was opposition from Alan Cox, who said that it crashes
> some machines hard. On the other hand, that is a BIOS interaction bug
> that most likely can be fixed and is very rare. I'd prefer a
> 'usb-no-handoff' switch for these machines.

I'm not opposed to that. The only real constraint to avoid the majority
of problem boxes I've seen is that the handoff is done with a timeout
and we continue in BIOS mode if the handoff fails.

The ACPI updates for VIA also seem to have cured some boxes that die
with USB enabled.

Alan

