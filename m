Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbSLKAgX>; Tue, 10 Dec 2002 19:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266444AbSLKAgX>; Tue, 10 Dec 2002 19:36:23 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:30913
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266310AbSLKAgX>; Tue, 10 Dec 2002 19:36:23 -0500
Subject: Re: IDE feature request & problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
Cc: Petr Sebor <petr@scssoft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <039d01c2a0ab$b19a5ad0$551b71c3@krlis>
References: <068d01c29d97$f8b92160$551b71c3@krlis><1039312135.27904.11.camel@irongate.sw
	 ansea.linux.org.uk><20021208234102.GA8293@scssoft.com> 
	<021401c2a05d$f1c72c80$551b71c3@krlis>
	<1039540202.14251.43.camel@irongate.swansea.linux.org.uk> 
	<039d01c2a0ab$b19a5ad0$551b71c3@krlis>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 01:20:43 +0000
Message-Id: <1039569643.14166.105.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 00:24, Milan Roubal wrote:
> Hi Alan,
> I have got xfs partition and man fsck.xfs say
> that it will run automatically on reboot.

You need to force one. Something (I assume XFS) asked the disk for a
stupid sector number. Thats mostly likely due to some kind of internal
corruption on the XFS

