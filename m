Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292870AbSCOQVM>; Fri, 15 Mar 2002 11:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292881AbSCOQVC>; Fri, 15 Mar 2002 11:21:02 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:64785 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S292870AbSCOQUw>; Fri, 15 Mar 2002 11:20:52 -0500
Message-Id: <200203151720.g2FHKTgg014925@pincoya.inf.utfsm.cl>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: 2.4.19pre2aa1 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Tue, 12 Mar 2002 15:25:34 +0100." <20020312152534.U25226@dualathlon.random> 
Date: Fri, 15 Mar 2002 13:20:29 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> said:

[...]

> AFIK my current hashfn is never been tested in precendence on this kind
> of random input of the wait_table pages.

If the input is really random, anything will do. I.e., just chopping off a
few not guaranteed-zero bits (probably better low-end) and using that would
be enough.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
