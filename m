Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318114AbSG2XJp>; Mon, 29 Jul 2002 19:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318116AbSG2XJo>; Mon, 29 Jul 2002 19:09:44 -0400
Received: from jalon.able.es ([212.97.163.2]:14063 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318114AbSG2XJo>;
	Mon, 29 Jul 2002 19:09:44 -0400
Date: Tue, 30 Jul 2002 01:12:03 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: oopsen with rc3-aa3
Message-ID: <20020729231203.GA6314@714-cm.cps.unizar.es>
References: <20020729174238.GA1919@714-cm.cps.unizar.es> <20020729181020.GU1201@dualathlon.random> <20020729223539.GA1936@714-cm.cps.unizar.es> <20020729224737.GJ1201@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020729224737.GJ1201@dualathlon.random>; from andrea@suse.de on mar, jul 30, 2002 at 00:47:37 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20020730 Andrea Arcangeli wrote:
> On Tue, Jul 30, 2002 at 12:35:39AM +0200, J.A. Magallon wrote:
> 
> it's not attached but never mind :) and yes it's the correct procedure.
>

Realized...
 
> btw, is it an hyperthreading cpu? Had you any problem with aa2?
> 

Full story: -rc3-jam1 (==aa1) works ok. Also -rc3-jam2 works. 
But -rc3-jam3 bombed on the dual-p4xeon box, but works on a PIII laptop.
So I tried plain -rc3-aa3 on the big box. It crashes with that
couple oopses.
Can't test on my home dual-pII (SMP but not xeon),
'cause the power source fried recently...

The laptop kernel is built with gcc-3.2 (latest Mandrake cooker), and the
dual-xeon one is built with gcc-2.96 (plain Mandrake 8.2).

