Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262463AbSJPNWU>; Wed, 16 Oct 2002 09:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSJPNWU>; Wed, 16 Oct 2002 09:22:20 -0400
Received: from [64.76.155.18] ([64.76.155.18]:58073 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S262463AbSJPNWT>;
	Wed, 16 Oct 2002 09:22:19 -0400
Date: Wed, 16 Oct 2002 10:28:14 -0300 (CLST)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.43 hangs silently on boot
Message-ID: <Pine.LNX.4.44.0210161018370.19750-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
trying to boot 2.5.43 it always hangs silently in the same task (loading 
keys), I'm using RedHat 8.0. When I press CRTL+Scroll Lock it always shows 
the same (copied by hand)

S17keytable              T   CB6F06A0     0   480     479      (L-TLB)
Call Trace:
[<c0121426>] do_exit+0x256/0x2b0
[<c01214b3>] sys_exit+0x13/0x20
[<c01094fb>] syscall_call+0x7/0xb

If I then press crtl-alt-supr it shows me task 'shutdown' and the last 
line of call trace is the same as above.

Any clues of what is happening? 

Config file: 
http://alumno.inacap.cl/~rmaureira/config-2.5.43

lspci -vx:
http://alumno.inacap.cl/~rmaureira/lspci-vx

Best Regards
-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

