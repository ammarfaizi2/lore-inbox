Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUCNT21 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 14:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUCNT21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 14:28:27 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:33773 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261580AbUCNT2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 14:28:25 -0500
Message-Id: <200403141926.i2EJPwio004819@eeyore.valparaiso.cl>
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Does sysfs really provides persistent hardware path to devices? 
In-Reply-To: Message from Andrey Borzenkov <arvidjaar@mail.ru> 
   of "Sun, 14 Mar 2004 14:53:56 +0300." <200403141453.59145.arvidjaar@mail.ru> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sun, 14 Mar 2004 15:25:57 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov <arvidjaar@mail.ru> said:

[...]

> I am trying to assign name for a USB slot on my PCs front so that when I
> plug in USB stick or USB drive or whatever I get the same name. Always.

Not necessary: You can mount by volume label, or UUID (Yes, need a sane
filesystem for that... and MS-DOS ones aren't. Sorry.)

Dangerous: You plug a _different_ USB stick in, and think it is the same.

Besides, plugging your drive in "the same place" on USB is useful today,
with 1 or 2 conectors. Add hubs, and you are talking about hundreds of
places... better concentrate on getting the machine keep track of
bureaucratic details.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
