Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268915AbTGJAMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268917AbTGJAJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 20:09:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39603
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268902AbTGJAIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 20:08:18 -0400
Subject: Re: Promise SATA 150 TX2 plus
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
Cc: Matthias Schniedermeyer <ms@citd.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mru@users.sourceforge.net
In-Reply-To: <03ab01c34677$225d53a0$401a71c3@izidor>
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com>
	 <027901c3461e$e023c670$401a71c3@izidor>
	 <yw1xadbnx017.fsf@users.sourceforge.net>
	 <02ff01c34642$5512d7f0$401a71c3@izidor> <20030709175827.GA412@citd.de>
	 <03ab01c34677$225d53a0$401a71c3@izidor>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057796402.7386.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 01:20:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-10 at 01:06, Milan Roubal wrote:
> Wow, how is the performance of this cards? HPT PATA controllers
> was always bad in performance and if it has got SATA to PATA converter,
> I can't imagine how fast/slow it could be.

If you are doing software raid its pretty irrelevant. With current
drives the cost of the multiple PCI transfers for each copy of the block
is the limiting factor on anything but PCI64/66Mhz really.

