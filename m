Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTFTACU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 20:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTFTACU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 20:02:20 -0400
Received: from [62.67.222.139] ([62.67.222.139]:23246 "EHLO kermit")
	by vger.kernel.org with ESMTP id S261989AbTFTACS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 20:02:18 -0400
Date: Fri, 20 Jun 2003 02:16:02 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Oops captured of 2.5.70-mm9, 2.5.71-mm1 and 2.5.72-mm1
Message-ID: <20030620001602.GA1806@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally I got it, well hopefully, cause I am a ksymoops greenhorn.
Since 2.5.70-mm9 I experience Desktop freezes which fell very similiar.
Mouse freezes -> you realize its not a lag -> sound stops -> freeze.

Over seriel line I got an output:

>>EIP; c02c8fc4 <contig_page_data+324/37c>   <=====
       
Trace; c011a016 <show_state+4b/8e>
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
Trace; f8ed1ef5 <_end+38b7cae5/3fca8bf0>
Trace; c01172d0 <do_page_fault+0/44b>
Trace; c0109a69 <error_code+2d/38>
Trace; f8e25caa <_end+38ad089a/3fca8bf0>
Trace; f8ec478a <_end+38b6f37a/3fca8bf0>
Trace; f8e37d2d <_end+38ae291d/3fca8bf0>
Trace; f8f034b7 <_end+38bae0a7/3fca8bf0>
Trace; f8f39882 <_end+38be4472/3fca8bf0>
Trace; f8f3962a <_end+38be421a/3fca8bf0>
Trace; f8ed76b4 <_end+38b822a4/3fca8bf0>
Trace; f8ed7265 <_end+38b81e55/3fca8bf0>
Trace; f8f5a000 <_end+38c04bf0/3fca8bf0>
Trace; c011a471 <autoremove_wake_function+0/4f>
Trace; f8f0171a <_end+38bac30a/3fca8bf0>
Trace; f8e3a199 <_end+38ae4d89/3fca8bf0>
Trace; f8e3ade0 <_end+38ae59d0/3fca8bf0>
Trace; c011fdd2 <tasklet_action+40/61>
Trace; c011fc1d <do_softirq+95/97>
Trace; c010b4e5 <do_IRQ+10c/13f>
Trace; c01099ac <common_interrupt+18/20>

the line beginning with >>EIP; varies somehow, but the pasted text seems
t be similair, the whole Oops is at 

http//www.ludenkalle.de/Oops

because its 350k in size...

Any help for advise in getting better layout or something highly
appreciated :)

Regardsm Konsti


-- 
2.5.72-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 19 min, 
