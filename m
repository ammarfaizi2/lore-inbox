Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbTCPNkG>; Sun, 16 Mar 2003 08:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262668AbTCPNkF>; Sun, 16 Mar 2003 08:40:05 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:10155 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262664AbTCPNkF>;
	Sun, 16 Mar 2003 08:40:05 -0500
Message-Id: <200303161242.h2GCg1PO001746@eeyore.valparaiso.cl>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1 
In-Reply-To: Your message of "Sun, 16 Mar 2003 03:32:54 PST."
             <20030316113254.GH20188@holomorphy.com> 
Date: Sun, 16 Mar 2003 08:42:01 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> said:

[...]

> Another thought I had was wrapping things in structures for both small
> and large, even UP systems so proper typechecking is enforced at all
> times. That would probably need a great deal of arch sweeping to do,
> especially as a number of arches are UP-only (non-SMP case's motive #2).

AFAIU, gcc doesn't put structures in registers (even when they fit).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
