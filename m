Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287828AbSANRdC>; Mon, 14 Jan 2002 12:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSANRcp>; Mon, 14 Jan 2002 12:32:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28421 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287804AbSANRch>; Mon, 14 Jan 2002 12:32:37 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: velco@fadata.bg (Momchil Velikov)
Date: Mon, 14 Jan 2002 17:43:13 +0000 (GMT)
Cc: Oliver.Neukum@lrz.uni-muenchen.de, yodaiken@fsmlabs.com,
        phillips@bonn-fries.net (Daniel Phillips),
        arjan@fenrus.demon.nl (Arjan van de Ven),
        zippel@linux-m68k.org (Roman Zippel), linux-kernel@vger.kernel.org
In-Reply-To: <87d70c51wk.fsf@fadata.bg> from "Momchil Velikov" at Jan 14, 2002 06:32:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QB8b-0002K8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oliver> You can have an rt task block on a lock held by a normal task that was 
> Oliver> preempted by a rt task of lower priority. The same problem as with the 
> Oliver> sched_idle patches.
> 
> This can happen with a non-preemptible kernel too. And it has nothing to
> do with scheduling policy.

So why bother adding pre-emption. As you keep saying - it doesnt
gain anything

Alan
