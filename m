Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSAIW64>; Wed, 9 Jan 2002 17:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289068AbSAIW6e>; Wed, 9 Jan 2002 17:58:34 -0500
Received: from oyster.morinfr.org ([62.4.22.234]:17572 "EHLO
	oyster.morinfr.org") by vger.kernel.org with ESMTP
	id <S285692AbSAIW6Z>; Wed, 9 Jan 2002 17:58:25 -0500
Date: Wed, 9 Jan 2002 23:58:23 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: walter <walt@nea-fast.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new kernel --this is wierd
Message-ID: <20020109225823.GA20827@morinfr.org>
Mail-Followup-To: walter <walt@nea-fast.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200201092250.RAA03139@int1.nea-fast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200201092250.RAA03139@int1.nea-fast.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dans un message du 09 jan à 17:50, walter écrivait :
> After upgrading to kernel-2.4.14-SGI_XFS_1.0.2 I can no longer connect to 
> www.zdnet.com. I can connect to any other web site. 

It seems that TCP ECN is on. Try echo 0 > /proc/sys/net/ipv4/tcp_ecn

-- 
Guillaume Morin <guillaume@morinfr.org>

       Unwisely, Santa offered a teddy bear to James, unaware that he had
             been mauled by a grizzly earlier that year (T. Burton)
