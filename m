Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbTLMO63 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 09:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbTLMO63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 09:58:29 -0500
Received: from intra.cyclades.com ([64.186.161.6]:36545 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265051AbTLMO61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 09:58:27 -0500
Date: Sat, 13 Dec 2003 12:54:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: jt@hpl.hp.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] IrDA kernel log buster
In-Reply-To: <20031211235131.GA1677@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0312131124040.1273-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Dec 2003, Jean Tourrilhes wrote:

> 	Hi Marcelo,
> 
> 	I just ran 2.4.23, and after a few min the disk reached 100%
> capacity. A quick check lead to to oversized kernel log, and to the
> following changeset :
> 
> http://linux.bkbits.net:8080/linux-2.4/cset@1.1136.23.2?nav=index.html|ChangeSet@-12w
> 
> 	Patch to fix this problem is attached below, I've just
> backported the proper fixes from 2.5.X into 2.4.X.
> 	Probably this person did too much Python, but in C you need
> braces around multiple statements part of the same branch, so the
> second printf was always executed even when logging was disabled. I
> also don't understand why this person didn't decided to backport the
> 2.5.X fix.
> 	I'm also bit surprised that this kind of patch went into the
> kernel behind my back, because I though that freeze meant not
> accepting untested patch from random hacker.

Indeed accepting the patch was a mistake. 

Fix applied.


