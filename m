Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263694AbUCUR6R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 12:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUCUR6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 12:58:17 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:4082 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263694AbUCUR6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 12:58:16 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: root@chaos.analogic.com, Jamie Lokier <jamie@shareable.org>
Subject: Re: spurious 8259A interrupt
Date: Sun, 21 Mar 2004 18:58:07 +0100
User-Agent: KMail/1.5.4
Cc: Robert_Hentosh@Dell.com, Linux kernel <linux-kernel@vger.kernel.org>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com> <20040319130609.GE2650@mail.shareable.org> <Pine.LNX.4.53.0403190825070.929@chaos>
In-Reply-To: <Pine.LNX.4.53.0403190825070.929@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403211858.07445.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 March 2004 14:48, Richard B. Johnson wrote:
>
> The IRQ7 spurious is usually an artifact of a crappy motherboard
> design where the CPU "thinks" it was interrupted, but the
> controller didn't wiggle the CPUs INT line.

Thanks for the nice explanation, Richard. 

I even see them on my x86_64 box in 64 bit mode. (K8VT800 based)
Furtunately only occasionally.

I thought, AMD took the chance to fix that kind of crap in the new 
architecture, but obviously they failed in this respect :-(

Pete

