Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbTLVNZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 08:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTLVNZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 08:25:10 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:15523 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264452AbTLVNZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 08:25:08 -0500
Message-ID: <3FE6F0AF.1050305@cyberone.com.au>
Date: Tue, 23 Dec 2003 00:25:03 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew McGregor <andrew@indranet.co.nz>
CC: Christian Meder <chris@onestepahead.de>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
References: <1071864709.1044.172.camel@localhost>	 <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au>	 <200312201355.08116.kernel@kolivas.org> <1071891168.1044.256.camel@localhost> <14897962.1072137278@[192.168.1.249]>
In-Reply-To: <14897962.1072137278@[192.168.1.249]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew McGregor wrote:

> Hmm.  Gnomemeeting has a history of strange threading issues 
> (actually, all OpenH323 derived projects do).  Is there a threading 
> change that might explain this?



Yes, changes in the way the scheduler deals with sched_yield.


