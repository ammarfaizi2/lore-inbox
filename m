Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264885AbUEVEnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264885AbUEVEnv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 00:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUEVEnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 00:43:51 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:29824 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S264885AbUEVEnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 00:43:49 -0400
Message-Id: <200405220443.i4M4hh631517@pincoya.inf.utfsm.cl>
To: "Timothy Miller" <theosib@hotmail.com>
cc: linux-kernel@vger.kernel.org, miller@techsource.com, vonbrand@inf.utfsm.cl
Subject: Re: [OT] Linux stability despite unstable hardware 
In-reply-to: Your message of "Fri, 21 May 2004 17:57:09 -0400."
             <BAY1-F135u0T4Dk5Je6000264da@hotmail.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sat, 22 May 2004 00:43:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Timothy Miller" <theosib@hotmail.com> said:
> I have had some issues recently with memory errors when using aggressive 
> memory timings.  Although memory tests pass fine, gcc would tend to crash 
> and would generate incorrect code when compiling other things. Gcc couldn't 
> even build itself properly under those conditions.

Really? memtest86 <http://www,memtest86.com> did finish its run without
errors? I'm sure they'd want to get their hands on the broken RAM...

> The really interesting thing is that the Linux kernel was totally 
> unaffected.  Compiling the Linux kernel is often thought of as a stressful 
> thing for a system, yet compiling a kernel with a broken gcc on a system 
> with intermittent memory errors goes through error free, and the kernel is 
> 100% stable when running.

Sure enough, if the kernel lives (mostly) in unaffected memory, and
furthermore doesn't bang on it quite as hard as a compiler run does (the
kernel only runs for a tiny fraction of the time).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
