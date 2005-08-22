Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVHVUHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVHVUHM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVHVUHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:07:11 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:18141 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750798AbVHVUHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:07:10 -0400
Date: Mon, 22 Aug 2005 10:45:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Michael Ellerman <michael@ellerman.id.au>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes. Also some X trouble.
In-Reply-To: <Pine.LNX.4.58.0508221034090.3317@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0508221044390.3317@g5.osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <42F89F79.1060103@aitel.hist.no>
 <200508171326.21948@bilbo.math.uni-mannheim.de> <200508221001.39050@bilbo.math.uni-mannheim.de>
 <Pine.LNX.4.58.0508221034090.3317@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Aug 2005, Linus Torvalds wrote:
>
> Eike, maybe you could change the ">=" to just ">" instead?

Ahh, I think you'd need to change the "i < PCI_ROM_RESOURCE" a few lines
above that to use "<=" too.

		Linus
