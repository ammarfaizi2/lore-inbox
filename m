Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUCVRTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 12:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUCVRTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 12:19:14 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:56013 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262129AbUCVRTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 12:19:11 -0500
Message-Id: <200403221719.i2MHJ2i9003913@eeyore.valparaiso.cl>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File change notification (enhanced dnotify) 
In-Reply-To: Your message of "Mon, 22 Mar 2004 11:41:46 EST."
             <405F174A.3090706@sun.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 22 Mar 2004 13:19:02 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison <Michael.Waychison@Sun.COM> said:
> Rüdiger Klaehn wrote:
> | My original approach assumed that inode numbers were unique, and it
> | would have worked with hard links. But I think it is much more important
> | to have a mechanism that works for all file systems than to solve the
> | problem of hard links.

> Inode numbers are guaranteed to be unique on a given filesystem other
> than for hard links..  Where is this assumption broken otherwise?

On some non-Unix filesystems there isn't an equivalent to (invariant) inode
numbers.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
