Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317691AbSGUPbT>; Sun, 21 Jul 2002 11:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSGUPbT>; Sun, 21 Jul 2002 11:31:19 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3830 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317691AbSGUPbT>; Sun, 21 Jul 2002 11:31:19 -0400
Subject: Re: [PATCH] strict VM overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0207211438440.11656-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0207211438440.11656-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 17:46:35 +0100
Message-Id: <1027269995.16818.106.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 13:46, Adrian Bunk wrote:
> With enough stupidity root can always trash his system but if as Robert
> says the state of the system will be that "no allocations will succeed"
> which seems to be a synonymous for "the system is practically dead" it is
> IMHO a good idea to let "swapoff -a return -ENOMEM".

In the overcommit mode I already suggested that. An administrator can
turn off overcommit protection if he really really needs to swapoff
regardless of the consequences (eg failing swap disk)

