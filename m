Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287866AbSAUSxm>; Mon, 21 Jan 2002 13:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287886AbSAUSxW>; Mon, 21 Jan 2002 13:53:22 -0500
Received: from ua18d4hel.dial.kolumbus.fi ([62.248.131.18]:52300 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S287866AbSAUSxQ>; Mon, 21 Jan 2002 13:53:16 -0500
Message-ID: <3C4C6261.98171243@kolumbus.fi>
Date: Mon, 21 Jan 2002 20:48:01 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Robbert Kouprie <robbert@jvb.tudelft.nl>
CC: "'Kenneth MacDonald'" <kenny@holyrood.ed.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
In-Reply-To: <005e01c1a1fc$d61eae50$020da8c0@nitemare>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robbert Kouprie wrote:
> 
> Thanks for the quick reply :) Just checked it, and it's in slot 2, so
> that's not the problem. It doesn't share the HPT366 IRQ. This is my
> /proc/interrupts:

Driver is eepro100? I suspect there is something in eepro100 driver that
should be protected by a spinlock but is not. I haven't got time to analyze
it further, yet...


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

