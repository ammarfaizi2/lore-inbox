Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263258AbTCNHMo>; Fri, 14 Mar 2003 02:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263261AbTCNHMo>; Fri, 14 Mar 2003 02:12:44 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:44088
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263258AbTCNHMn>; Fri, 14 Mar 2003 02:12:43 -0500
Date: Fri, 14 Mar 2003 02:20:14 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] irq handling code consolidation (common part)
In-Reply-To: <20030313134318.GL1393@pazke>
Message-ID: <Pine.LNX.4.50.0303140040160.17112-100000@montezuma.mastecende.com>
References: <20030313132148.GG1393@pazke> <Pine.LNX.4.50.0303130830520.6957-100000@montezuma.mastecende.com>
 <20030313134318.GL1393@pazke>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003, Andrey Panin wrote:

> I interested in any test results, tests on non x86 machines are especially 
> welcome. I tested common and i386 patches on my home dualcpu pc and single
> cpu visual workstation, but wider testing is needed.

Tested in the following configurations (hardware courtesy of OSDL)
32way i686/NUMAQ/SMP w/ IOAPIC	- passed
32way i686/NUMAQ/SMP w/o IOAPIC	- passed 
8way i686/SMP kernel w/ IOAPIC	- passed
8way i686/SMP kernel w/o IOAPIC	- passed  

Thanks!
	Zwane
