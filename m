Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317279AbSGaMJU>; Wed, 31 Jul 2002 08:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317987AbSGaMJU>; Wed, 31 Jul 2002 08:09:20 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24821 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317279AbSGaMJT>; Wed, 31 Jul 2002 08:09:19 -0400
Subject: RE: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Luyer <david@luyer.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00b601c23881$a8dfa180$638317d2@pacific.net.au>
References: <00b601c23881$a8dfa180$638317d2@pacific.net.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 Jul 2002 14:28:45 +0100
Message-Id: <1028122125.8510.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> procps version is 2.0.7 (Debian 3.0).
> 
> Where's the mistake -- should timer interrupts be on both
> CPUs (I think this is the problem), or is procps miscalculating
> Hz (seems less likely, someone would have noticed by now...)?

HZ on x86 for user space is defined as 100. Its a procps problem

