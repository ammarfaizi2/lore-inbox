Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWI2Rxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWI2Rxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWI2Rxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:53:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46273 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751210AbWI2Rxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:53:36 -0400
Subject: Re: PCI bridge missing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luke-Jr <luke@dashjr.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609291228.38799.luke@dashjr.org>
References: <200609281624.16082.luke@dashjr.org>
	 <1159485255.13029.7.camel@localhost.localdomain>
	 <200609291228.38799.luke@dashjr.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 19:18:40 +0100
Message-Id: <1159553920.13029.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-29 am 12:28 -0500, ysgrifennodd Luke-Jr:
> On Thursday 28 September 2006 6:14 pm, Alan Cox wrote:
> > lspci -vvxxx would be interesting
> 

Ok so the 21152 just isn't seen by Linux. Ok try this

lspci -vvxxx -H1 -M

that will try and do a hardware level scan and map

