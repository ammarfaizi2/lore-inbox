Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270210AbTHLMGy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 08:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270228AbTHLMGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 08:06:54 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:4602 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S270210AbTHLMGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 08:06:52 -0400
Subject: Re: 2.6.0-test3+sk98lin driver with hardware bug make eth unusable
From: Martin Schlemmer <azarah@gentoo.org>
To: Ricardo Galli <gallir@uib.es>
Cc: Mirko Lindner <mlindner@syskonnect.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308121301.43873.gallir@uib.es>
References: <200308121301.43873.gallir@uib.es>
Content-Type: text/plain
Message-Id: <1060689676.13254.172.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 12 Aug 2003 14:01:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-12 at 13:01, Ricardo Galli wrote:
> I've already reported this problem to syskonnect few weeks ago (without 
> success as I see). 
> 
> There is a ASIC bug in several popular motherboards (including ASUS ones) 
> related to TX hardware checksum. 
> 
> For packets smaller that 56 bytes (payload), as UDP dns queries, the asic 
> generates a bad checksum making the drivers unusable for "normal" Internet 
> usage:
> 

<snip>

> The only solution is to comment out
>  #define USE_SK_TX_CHECKSUM
> in skge.c
> 

Known issue.

Mirko will have a look as soon as he have time.


Cheers,

-- 
Martin Schlemmer


