Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTFTMo6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 08:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTFTMo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 08:44:58 -0400
Received: from [62.67.222.139] ([62.67.222.139]:10712 "EHLO kermit")
	by vger.kernel.org with ESMTP id S263077AbTFTMo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 08:44:57 -0400
Date: Fri, 20 Jun 2003 14:58:50 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.72-mm1 freeze
Message-ID: <20030620125850.GA1606@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again 2.5.72-mm1 froze while clicking around in konqueror :(
This time the ksymoops output is half of the size of yesterday but looks
very similair. Does it look like Hardware error or kernel error? If the
latter its not importand to fix it now, I only wan't to know if my
Hardware is broken or not :/

http://www.ludenkalle.de/Oops20030619
380kB
and
http://www.ludenkalle.de/Oops20030620
190kB

>>EIP; d9274998 <_end+18f1f588/3fca8bf0>   <=====
                                                                                                                       Trace;
c011a016 <show_state+4b/8e>
Trace; c01f3518 <__handle_sysrq_nolock+73/e7>
Trace; c01f3491 <handle_sysrq+4a/5e>
Trace; c01f7953 <receive_chars+12c/272>
Trace; c01f7dae <serial8250_interrupt+102/104>
Trace; c010b146 <handle_IRQ_event+3a/64>
Trace; c010b473 <do_IRQ+9a/13f>
Trace; c01099ac <common_interrupt+18/20>
Trace; c011c2fa <panic+de/ff>
Trace; c010a091 <die+ea/fd>
Trace; c011741a <do_page_fault+14a/44b>
Trace; c022e877 <sock_alloc_send_pskb+c3/1db>
Trace; c0230b01 <memcpy_fromiovec+83/89>
Trace; f8f54ef5 <_end+38bffae5/3fca8bf0>
Trace; c01172d0 <do_page_fault+0/44b>
Trace; c0109a69 <error_code+2d/38>
Trace; f8ea8caa <_end+38b5389a/3fca8bf0>
Trace; f8f4778a <_end+38bf237a/3fca8bf0>
Trace; f8ebad2d <_end+38b6591d/3fca8bf0>
Trace; f8f864b7 <_end+38c310a7/3fca8bf0>
Trace; f8fbc882 <_end+38c67472/3fca8bf0>
Trace; f8fbc62a <_end+38c6721a/3fca8bf0>
Trace; f8f5a6b4 <_end+38c052a4/3fca8bf0>
Trace; f8f5a265 <_end+38c04e55/3fca8bf0>
Trace; f8fdd000 <_end+38c87bf0/3fca8bf0>
Trace; c011a471 <autoremove_wake_function+0/4f>
Trace; f8f8471a <_end+38c2f30a/3fca8bf0>
Trace; f8ebd199 <_end+38b67d89/3fca8bf0>
Trace; f8ebdde0 <_end+38b689d0/3fca8bf0>
Trace; c011fdd2 <tasklet_action+40/61>
Trace; c011fc1d <do_softirq+95/97>
Trace; c010b4e5 <do_IRQ+10c/13f>
Trace; c01099ac <common_interrupt+18/20>

Many very similar Blocks looking like this with varying >>EIP; lines...

Konsti

-- 
2.5.72-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 28 min, 
