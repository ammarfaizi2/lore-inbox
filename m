Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267331AbSLLAvl>; Wed, 11 Dec 2002 19:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267377AbSLLAvl>; Wed, 11 Dec 2002 19:51:41 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:46532
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267331AbSLLAvk>; Wed, 11 Dec 2002 19:51:40 -0500
Subject: Re: HyperThreading in recent 2.4-ac kernels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerald Britton <gbritton@alum.mit.edu>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021211183059.A19030@light-brigade.mit.edu>
References: <200212112043.gBBKhLE28272@devserv.devel.redhat.com> 
	<20021211183059.A19030@light-brigade.mit.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 01:36:59 +0000
Message-Id: <1039657019.18467.65.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 23:30, Gerald Britton wrote:
> HyperThreading appears to work properly in vanilla 2.4.x, but fails to
> initialize the sibling CPUs in 2.4.x-ac.  The problem appears to be in
> improper indexing by physical vs. logical CPU numbers.

Thanks. Can you verify 2.4.21-pre1 is ok. That has the latest and
greatest code in these areas and code -ac will drop its development
atuff for. If 2.4.21-pre1 works all is cool, if not it would be very
good to know early on

