Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbULEF2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbULEF2O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 00:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbULEF2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 00:28:14 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58796 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261247AbULEF2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 00:28:11 -0500
Message-Id: <200412050023.iB50NUdF025947@laptop11.inf.utfsm.cl>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Imanpreet Singh Arora <imanpreet@gmail.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What if? 
In-Reply-To: Message from Jan Engelhardt <jengelh@linux01.gwdg.de> 
   of "Thu, 02 Dec 2004 11:25:09 BST." <Pine.LNX.4.53.0412021124450.1873@yvahk01.tjqt.qr> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Sat, 04 Dec 2004 21:23:29 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> said:
> Imanpreet Singh Arora <imanpreet@gmail.com> said:
> >    Firstly I have read the FAQ. So though FAQ answers my question, it
> >does so only partially.
> >
> >    "What if Linux were to be implemented in C++?"

> To quota Alan Cox (IIRC): "Been there, done that, threw it out".

Not really. There was support to compile Linux using g++ for a C compiler
some time back (because of better (at the time) type checking), the result
was horrible (mainly due to compiler bugs, IIRC). The gain wasn't near
worth the pain.

Rewriting Linux in C++ means fundamental redesign(s); as mentioned, the VFS
would become a class, as would the driver interfaces, and much more. The
object model inside Linux is sufficiently different from C++'s that it
would be a _huge_ job. And pointless, you'd just get Linux as it stands
today, and loose many current developers (due to unfamiliarity with C++).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
