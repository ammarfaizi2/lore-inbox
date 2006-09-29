Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161435AbWI2Sxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161435AbWI2Sxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161443AbWI2Sxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:53:45 -0400
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:4301 "EHLO
	hachi.dashjr.org") by vger.kernel.org with ESMTP id S1161435AbWI2Sxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:53:44 -0400
From: Luke-Jr <luke@dashjr.org>
Organization: -Jr family
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PCI bridge missing
Date: Fri, 29 Sep 2006 13:53:30 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200609281624.16082.luke@dashjr.org> <200609291228.38799.luke@dashjr.org> <1159553920.13029.62.camel@localhost.localdomain>
In-Reply-To: <1159553920.13029.62.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609291353.33843.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Go figure. Apparently the counterfiet-3Com NIC somehow disables the entire 
daughterboard. I found another GX1p and used its daughterboard, noticed it 
worked, then assumed the first one was bad... put the NIC in the second one 
and it's "bad" all of a sudden. Both show up in lspci if I take the NICs out.

FWIW, the NIC claims to be 3C905CX-TXM assembled in USA and matches the 
picture of the counterfeit 3Com cards in 
http://www.heise.de/newsticker/data/ea-20.08.02-000/ (bottom of the second 
picture)
