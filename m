Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUB1QFk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 11:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUB1QFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 11:05:40 -0500
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:25516
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261876AbUB1QFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 11:05:39 -0500
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040228012630.GA3074@codepoet.org>
References: <403F2178.70806@vanE.nl>
	 <200402272114.23108.bzolnier@elka.pw.edu.pl>
	 <20040227224431.GB984@codepoet.org>
	 <200402280220.22324.bzolnier@elka.pw.edu.pl>
	 <20040228012630.GA3074@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1077984093.31248.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 28 Feb 2004 16:01:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-02-28 at 01:26, Erik Andersen wrote:
> > Now I remember why this wasn't applied.
> > It breaks braindamaged HDIO_GETGEO_BIG_RAW ioctl
> > (because changes way drive->cyls is calculated).
> > We workaround-ed it in 2.6 by removing this ioctl. :)
> > I think we really should do the same for 2.4.
> 
> I did just that but it was rejected by Alan Cox...
> http://www.ussg.iu.edu/hypermail/linux/kernel/0308.2/0193.html

You can't go around randomly removing bad ideas during a stable
tree. Sucks but true.

Alan

