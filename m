Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbTLHJDT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 04:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbTLHJDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 04:03:19 -0500
Received: from AGrenoble-101-1-3-175.w193-253.abo.wanadoo.fr ([193.253.251.175]:41177
	"EHLO awak") by vger.kernel.org with ESMTP id S265351AbTLHJDQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 04:03:16 -0500
Subject: Re: 2.6.test11 bug
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rafal Skoczylas <nils@secprog.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.58.0312072100250.13236@home.osdl.org>
References: <20031208034631.GA14081@secprog.org>
	 <Pine.LNX.4.58.0312072100250.13236@home.osdl.org>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1070874166.869.57.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Dec 2003 10:02:48 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 08/12/2003 à 06:17, Linus Torvalds a écrit :
> It could be bad memory. We even know the address that is bad: it's
> (%esi+4), ie bit 31 of the word at physical address 0x1b0468f0.
> 
> However, if you don't see random SIGSEGV's while compiling etc issues, it
> doesnt' sound like flaky RAM.

(FWIW) I have a server running 2.4.22 and pppoe (to talk to an ADSL
modem). It works really flawlessly *except* when I run mldonkey: then
pppoe regularly fails and drops the connection. As this thing generates
a lot of packets to/from different hosts, I suspects it's an excellent
test workload for some paths of the kernel.

	Xav

