Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266122AbSKTNeO>; Wed, 20 Nov 2002 08:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSKTNeO>; Wed, 20 Nov 2002 08:34:14 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:14209 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266121AbSKTNeM>; Wed, 20 Nov 2002 08:34:12 -0500
Subject: Re: RFC - new raid superblock layout for md driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
In-Reply-To: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 14:09:41 +0000
Message-Id: <1037801381.3267.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 04:09, Neil Brown wrote:
>     u32  set_uuid[4]

Wouldnt u8 for the uuid avoid a lot of endian mess

>     u32  ctime

Use some padding so you can go to 64bit times


