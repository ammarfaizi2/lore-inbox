Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318960AbSHWRM1>; Fri, 23 Aug 2002 13:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318963AbSHWRM1>; Fri, 23 Aug 2002 13:12:27 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:42232 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318960AbSHWRM1>; Fri, 23 Aug 2002 13:12:27 -0400
Subject: Re: Linux 2.4.20-pre4-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anssi Saari <as@sci.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020823163056.GA7426@sci.fi>
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com> 
	<20020823163056.GA7426@sci.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 23 Aug 2002 18:18:09 +0100
Message-Id: <1030123089.5932.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-23 at 17:30, Anssi Saari wrote:
> Audio CD writes hog system if writing at > 4x so that CPU intensive
> stuff like watching video goes poorly, frames are dropped a lot, even

Linux audio writes are currently always done PIO. Andrew Morton posted a
patch for this which I need to dig out and merge.

