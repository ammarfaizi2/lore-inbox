Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVLGQF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVLGQF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVLGQF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:05:29 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:32416 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751154AbVLGQF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:05:28 -0500
Message-Id: <200512071605.jB7G5M84007973@laptop11.inf.utfsm.cl>
To: Massimiliano Hofer <max@bbs.cc.uniud.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Massimiliano Hofer <max@bbs.cc.uniud.it> 
   of "Wed, 07 Dec 2005 15:38:54 BST." <200512071538.55967.max@bbs.cc.uniud.it> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Wed, 07 Dec 2005 13:05:22 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 07 Dec 2005 13:05:22 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Massimiliano Hofer <max@bbs.cc.uniud.it> wrote:

[...]

> I maintain a number of servers and don't like to depend on a distro for
> the kernel. I do my tests before deployment and can live with some
> problems in a specific release (noone is perfect), but I'd like to have a
> plan B without creating my own branch.

Reasonable.

> Having security patches in a 2.6.(x-1).y would allow me to test the
> latest vanilla AND have stable production servers without the rush that
> usually accompanies a new release followed by a vulnerability.

You can certainly keep 2.6.x.y for a while when 2.6.(x+1) shows up, and
even wait for 2.6.(x+1).1. Note that the stable series maintainers are
sypmathetic to the idea of doing a last 2.6.x.(y+1), flushing the queued
patches when 2.6.(x+1) shows up. Is this enough for you?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
