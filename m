Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288477AbSAYXuH>; Fri, 25 Jan 2002 18:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSAYXtr>; Fri, 25 Jan 2002 18:49:47 -0500
Received: from jalon.able.es ([212.97.163.2]:31887 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S288477AbSAYXtj>;
	Fri, 25 Jan 2002 18:49:39 -0500
Date: Sat, 26 Jan 2002 00:49:28 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Alexander Viro <viro@math.psu.edu>
Cc: Timothy Covell <timothy.covell@ashavan.org>,
        Xavier Bestel <xavier.bestel@free.fr>, Robert Love <rml@tech9.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020126004928.A3780@werewolf.able.es>
In-Reply-To: <200201250720.g0P7KeL09793@home.ashavan.org.> <Pine.GSO.4.21.0201250244070.23657-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.GSO.4.21.0201250244070.23657-100000@weyl.math.psu.edu>; from viro@math.psu.edu on vie, ene 25, 2002 at 08:48:37 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020125 Alexander Viro wrote:
>
>Seriously, learn C.  The fact that you don't understand it is _your_
>problem - l-k is not a place to teach you the langauge.
>

Please, stop with that thing of 'learn C'. C can have bad design points.
It is not perfect. Deal with it, but do not make it a god.

For this special case, what is so bad in halting people to write code
like

a = b + (c>7);

and write it like

a = b + (c>7 ? 1 : 0);

Let the compiler do its work.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre7-slb #3 SMP Thu Jan 24 02:54:46 CET 2002 i686
