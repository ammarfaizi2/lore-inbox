Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268565AbTBWUZU>; Sun, 23 Feb 2003 15:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268920AbTBWUZU>; Sun, 23 Feb 2003 15:25:20 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17280
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268565AbTBWUZS>; Sun, 23 Feb 2003 15:25:18 -0500
Subject: Re: Linux-2.5.62-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
Cc: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030223211901.A3928@pc9391.uni-regensburg.de>
References: <20030223211901.A3928@pc9391.uni-regensburg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046036189.1669.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 23 Feb 2003 21:36:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-23 at 20:19, Christian Guggenberger wrote:
> Should this one fix those problems with IO-APICs seen on most UP Via Boards?

Some - there are rather a lot of variables involved. This fixes up one specific
problem (or should do). It writes the IRQ back to the PCI devices, which is
needed for internal devices.

The fact it still fails in your case makes me wonder if the workaround isnt
being properly triggered

