Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVFEPFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVFEPFl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 11:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFEPFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 11:05:40 -0400
Received: from ms.iem.uni-due.de ([132.252.150.1]:60070 "EHLO
	pilz.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id S261584AbVFEPFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 11:05:24 -0400
Date: Sun, 5 Jun 2005 17:03:42 +0200
From: Birger Toedtmann <btoedtmann@iem.uni-due.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IRQ exception upon networking with many vifs/bridges (using Xen)
Message-ID: <20050605150342.GA8976@exp-math.uni-essen.de>
References: <1117964324.2494.15.camel@lomin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1117964324.2494.15.camel@lomin>
X-Echelon: Cocaine Kill Evil Contract Whitehouse Attack Bomb Money Terror American Hate
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Birger Tödtmann schrieb am Sun, Jun 05, 2005 at 11:38:43AM +0200:
> 
> Hello,
> 
> (- this is sort of crossposting from Xen mailing lists, because I do
>    not know whether this is very Xen specific as the domain0 linux
>    kernel is crashing with a 'fatal exception in interrupt' - see
>    below for details.)

Forget about it, as I just infered from the call trace the problem happens 
somewhere inside net_rx_action() in ./drivers/xen/netback/netback.c, not
./net/core/dev.c, so it's solely related to Xen modifications.


-- 
Birger Tödtmann
Technik der Rechnernetze, Institut für Experimentelle Mathematik und Institut 
für Informatik und Wirtschaftsinformatik, Universität Duisburg-Essen
email:btoedtmann@iem.uni-due.de skype:birger.toedtmann pgp:0x6FB166C9 icq:294947817
