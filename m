Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbSL3Mtw>; Mon, 30 Dec 2002 07:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbSL3Mtw>; Mon, 30 Dec 2002 07:49:52 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59776
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266952AbSL3Mts>; Mon, 30 Dec 2002 07:49:48 -0500
Subject: Re: 2.4.21-pre2: CPU0 handles all interrupts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hans Lambrechts <hans.lambrechts@skynet.be>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212301240.04998.hans.lambrechts@skynet.be>
References: <200212281056.58419.hans.lambrechts@skynet.be>
	<200212281103.36973.rcooper@jamesconeyisland.com>
	<1041212142.1474.33.camel@irongate.swansea.linux.org.uk> 
	<200212301240.04998.hans.lambrechts@skynet.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 13:39:44 +0000
Message-Id: <1041255584.13076.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 11:40, Hans Lambrechts wrote:
> maybe this snippet from patch-2.4.21-pre2.gz is the culprit:

Shouldn't be but it is possibly the cause. There are some measurable
APIC handling changes in 2.4.21 that might trip something up

