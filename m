Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319122AbSIDKvT>; Wed, 4 Sep 2002 06:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319126AbSIDKvT>; Wed, 4 Sep 2002 06:51:19 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:35571
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319122AbSIDKvS>; Wed, 4 Sep 2002 06:51:18 -0400
Subject: Re: X.25 Support in Kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <al4ihm$h34$1@forge.intermeta.de>
References: <al4ihm$h34$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 11:56:22 +0100
Message-Id: <1031136982.2796.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 10:08, Henning P. Schmiedehausen wrote:
> Basically I need to talk to a Cisco router with X.25 protocol and be
> able to terminate an X.25 connection in user space in an
> application. As far as I can see, there is the easy way talking XOP
> with the router or talking X.25 over LLC2 (which Cisco calls CMNS) for
> which support seems to be "not yet completely functional".
> 
> Considering the possibility of hacking with the x.25 part of the kernel;
> which would be the best way to start with LLC2 support? Using the driver
> from linux-sna or hacking with net/llc ?

The base kernel llc code is junk. Thats been rewritten by the SNA folks
and also used by the netbeui for Linux people. That should give you
enough to talk X.25/X.29 over LLC pink book style

