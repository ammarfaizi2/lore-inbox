Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWI0Lya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWI0Lya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWI0Lya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:54:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4268 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030192AbWI0Lya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:54:30 -0400
Subject: Re: GPLv3 Position Statement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
	 <1159319508.16507.15.camel@sipan.sipan.org>
	 <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
	 <1159342569.2653.30.camel@sipan.sipan.org>
	 <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 27 Sep 2006 13:19:00 +0100
Message-Id: <1159359540.11049.347.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-27 am 10:58 +0200, ysgrifennodd Jan Engelhardt:
> I think Linus once said that he does not consider the kernel to 
> become part of a combined work when an application uses the kernel.

COPYING top of the kernel source tree.

> I tend to agree, it's gray (unless Linus explicitly colorizes it) -- 
> IIRC the GPL allows a GPL and closed program to interact if they do so 
> using 'standard' interfaces, i.e. passing a file as argument, or 
> shell redirection, communicating over a pipe or a socket, etc.
> But OTOH, linking code makes it a combined work.

No. The definition of a derivative work is a legal one and not a
technical one. Take a look at the history of the objective C compiler
front end for gcc. It is possible that linked code is not derivative or
pipe using code is derivative - consider for example RPC. Simply making
a linux device driver make the same function calls to the kernel by RPC
messages over a pipe type device would not change its status.

Alan

