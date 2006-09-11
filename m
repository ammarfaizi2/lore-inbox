Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWIKJt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWIKJt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWIKJt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:49:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19369 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932221AbWIKJt0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:49:26 -0400
Subject: Re: design of screen-locks for text-mode sessions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Travis H." <solinym@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d4f1333a0609110240n3904e5a9g4359c338004008ae@mail.gmail.com>
References: <d4f1333a0609110240n3904e5a9g4359c338004008ae@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Sep 2006 11:12:44 +0100
Message-Id: <1157969564.23085.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-11 am 04:40 -0500, ysgrifennodd Travis H.:
> off-list with interested parties.  In the meantime, I was wondering what people
> thought about the best design for locking text-mode console sessions.  It's a
> checkbox on some regulatory compliance list, I think for the PCI specs (that's
> credit cards, not the bus) and I'm sort of surprised there isn't an easy-to-find
> package for this.

We should have everything you need in kernel to do this. You can lock
the console switching and monitor the keyboard just fine. 

See "lockvt.c" (ask google to find it). It's tiny and it shows how to
use the lockswitch functionality. Then just add your timing junk.


Alan
