Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319124AbSIDKpL>; Wed, 4 Sep 2002 06:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319126AbSIDKpL>; Wed, 4 Sep 2002 06:45:11 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:33011
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319124AbSIDKpK>; Wed, 4 Sep 2002 06:45:10 -0400
Subject: Re: OSB4 in impossible state
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
Cc: ROBIN "Jean-Marie (EURIWARE)" <jmrobin@euriware.fr>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1031135030.3314.64.camel@biker.pdb.fsc.net>
References: <6005F8DAD235D611BDF80008C7EB75D01B008D@excsrvequ1.euriware> 
	<1031135030.3314.64.camel@biker.pdb.fsc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 11:49:25 +0100
Message-Id: <1031136565.2796.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 11:23, Martin Wilck wrote:
> Hmm - seems that DMA really doesn't work as it should. In this case my
> patch really only prevents the crash. For the moment, I can only advise
> you to start the kernel with the hda=nodma option.

Lots of older CD-ROM devices don't support DMA, so it may well not be a
controller problem this time. The other stuff is fixed in the current
-ac tree.

Alan

