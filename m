Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSLPW22>; Mon, 16 Dec 2002 17:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSLPW22>; Mon, 16 Dec 2002 17:28:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57311
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261963AbSLPW21>; Mon, 16 Dec 2002 17:28:27 -0500
Subject: Re: [PATCH] linux-2.4.21-pre1_cyclone-timer_B3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1040076206.1583.14.camel@w-jstultz2.beaverton.ibm.com>
References: <1040076206.1583.14.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Dec 2002 23:15:55 +0000
Message-Id: <1040080555.13787.109.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-16 at 22:03, john stultz wrote:
> Marcelo, All, 
> 	This patch fixes gettimeofday for multi-node Summit based systems (IBM
> x440, etc). These systems suffer from TSC skew, and thus require an
> alternate high res time source. This patch allows do_gettimeofday to
> access a register on the cyclone chip found on these systems, which
> functions as a global time source.
> 
> Please consider for acceptance. 

Older versions have been in -ac and seem fine

