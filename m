Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSKNByy>; Wed, 13 Nov 2002 20:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSKNByy>; Wed, 13 Nov 2002 20:54:54 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:17835 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261338AbSKNByy>; Wed, 13 Nov 2002 20:54:54 -0500
Subject: Re: module mess in -CURRENT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, rusty@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211131655580.6810-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211131655580.6810-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Nov 2002 02:27:20 +0000
Message-Id: <1037240840.14393.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-14 at 00:59, Linus Torvalds wrote:
> People who find the current module situation difficult can just compile in 
> the stuff they need for now.

That makes driver debugging almost impossible. It also makes building a
test kernel set for a lot of boxes impractical. The completely broken
unload stuff is going to be a real pig, PCMCIA only works modular and
doesn't work now the unloads are all broken. OTOH the module rewrite has
some nice features and a combo modutils is going to sort some of the
problem out fairly easily.

The biggest need though is documentation so people can actually fix all
the drivers for this stuff.




