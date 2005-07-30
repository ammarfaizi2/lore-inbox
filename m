Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVG3VbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVG3VbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVG3VbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:31:07 -0400
Received: from silver.veritas.com ([143.127.12.111]:49339 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S262893AbVG3Vam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:30:42 -0400
Date: Sat, 30 Jul 2005 22:32:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <200507302249.55409.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0507302231280.4946@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
 <200507302249.55409.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Jul 2005 21:30:38.0804 (UTC) FILETIME=[EE01C140:01C5954D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005, Rafael J. Wysocki wrote:
> 
> Well, the patch is needed on other boxes too (eg. mine :-)) due to the recent
> changes in ACPI.
> 
> Could you please send the /proc/interrupts from your box?

           CPU0       
  0:    2818513          XT-PIC  timer
  1:      56790          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
 11:      57443          XT-PIC  yenta, yenta, eth0
 12:     110579          XT-PIC  i8042
 14:      31332          XT-PIC  ide0
 15:     100988          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
