Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVKWTqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVKWTqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVKWTq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:46:29 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47830 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932249AbVKWTq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:46:29 -0500
Subject: Re: [BUG 2579] linux 2.6.* sound problems
From: Lee Revell <rlrevell@joe-job.com>
To: Ard van Breemen <ard@kwaak.net>
Cc: Patrizio Bassi <patrizio.bassi@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051123162216.GG1700@kwaak.net>
References: <53L1x-6dC-13@gated-at.bofh.it> <53LkE-6QU-5@gated-at.bofh.it>
	 <53LkW-6QU-49@gated-at.bofh.it> <53LEq-7gr-7@gated-at.bofh.it>
	 <43667406.9070104@gmail.com> <4366A49F.3000101@rainbow-software.org>
	 <43673B6F.5030909@gmail.com>  <20051123162216.GG1700@kwaak.net>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 14:46:18 -0500
Message-Id: <1132775178.10453.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 17:22 +0100, Ard van Breemen wrote:
> On Tue, Nov 01, 2005 at 10:54:55AM +0100, Patrizio Bassi wrote:
> > i played a bit with bios, but no luck.
> > considering that in my windows copy i have no problems, i'm sure it's
> > linux 2.6
> > 
> > update: can't use linux 2.4, i have nptl only and acpi problems too.
> > i'll play with timers and latency
> One more suggestion:
> try running distributed-net or something else that uses 100% cpu.
> I also have "bad sound" from on-board audio (hp nx9110 notebook
> and some elcheap asus motherboard). Usually it is a bad or cheap
> motherboard design.
> If using your CPU 100% fixes or mostly diminishes your audio
> distortion, you can be 100% sure that the audio part has a very
> bad design (no separate voltage controllers or good power supply
> filters, and no separate power supply circuit, and of course a
> good deal of crosstalk between analog lines and "digital" lines).
> 

Please try to isolate whether the PCI latency timer change OR the change
from HZ=250 to HZ=100 fixed the problem.

Lee

