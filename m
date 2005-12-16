Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVLPScL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVLPScL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVLPScL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:32:11 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:51121 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932285AbVLPScK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:32:10 -0500
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
Date: Fri, 16 Dec 2005 10:32:05 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Vitaly Wool <vwool@ru.mvista.com>,
       linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <43A27CDA.4020304@ru.mvista.com> <20051216173406.GC2122@kroah.com>
In-Reply-To: <20051216173406.GC2122@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512161032.06144.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Oh BTW... I'm experiencing constant problems with root filesystem over 
> > NFS over usbnet on my target

As you clarified off-line ... it's "pegasus", not "usbnet",
which is giving you problems.  That's entirely different code;
although "pegasus" could be modified to run on top of the
core that "usbnet" provides.

The problems I've seen with "pegasus" have more to do with
wierd chip behaviors (and weak fault recovery logic) than
with anything DMA-related.

- Dave
