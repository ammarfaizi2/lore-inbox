Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTFDLNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 07:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTFDLNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 07:13:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19331
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263205AbTFDLNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 07:13:34 -0400
Subject: Re: siimage slow on 2.4.21-rc6-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Mauk van der Laan <mauk.lists@maatwerk.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10306031746070.27756-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10306031746070.27756-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054722547.9233.93.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jun 2003 11:29:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-04 at 01:53, Andre Hedrick wrote:
> NO, it is not irrelevant.
> 
> Seagate and Silicon Image are the only two player (well intel now) who did
> their own PHY.  They did not use the Marvel pairs.

Ok I know about the maxtor+marvel phy problem I didnt know about SI phy
problems.

> I have to do other business ventures because being an independent
> developer/contract no longer can pay the bills.  More proof that free
> drivers and free software still has a cost to somebody.

Sure. Nobody is asking you to fix it all. I'll go bug SI as I've already
got the needed hooks in the 2.4 core code (although not 2.5 since the
taskfile stuff needs to get resolved first).

Alan

