Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbULUB1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbULUB1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 20:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbULUB1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 20:27:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:56451 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261646AbULUB1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 20:27:22 -0500
Subject: Re: Cyrix 6x86 Comma Bug 2.6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200412210026.17426.vda@port.imtp.ilyichevsk.odessa.ua>
References: <41C41A04.8030009@tiscali.de>
	 <200412210026.17426.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103588598.32550.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Dec 2004 00:23:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-20 at 22:26, Denis Vlasenko wrote:
> It is very unlikely that you see "Coma" bug. It can be triggered only
> by deliberately coded tight endless loop. "Ugly tokens on the screen"
> suggest that you see something else.

Presumably those tokens included "Oops" somewhere near the top and
function names. The Cyrix stuff is notoriously hard to keep cool so that
may be a good thing to check, as well as running memtest86+ to check the
RAM.

Also some very early stepping 6x86 Cyrixes simply don't run Linux
reliably and it seemed to be cache problems in the CPU.
