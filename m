Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279642AbRKFP1J>; Tue, 6 Nov 2001 10:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279596AbRKFP1A>; Tue, 6 Nov 2001 10:27:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58889 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279642AbRKFP0n>; Tue, 6 Nov 2001 10:26:43 -0500
Subject: Re: oops with 2.4.13-ac8
To: olh@suse.de (Olaf Hering)
Date: Tue, 6 Nov 2001 15:33:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011106160200.A7291@suse.de> from "Olaf Hering" at Nov 06, 2001 04:02:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1618EZ-0000oP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>EIP; c011946a <update_one_process+1a/d4>   <=====
> Trace; c011953c <update_process_times+18/88>
> Trace; c011985e <do_timer+22/6c>
> Trace; c010a8dc <timer_interrupt+d0/18c>

Nice trace. Looks like somehow we took an IRQ with %cr2 not holding valid
data.

Alan
