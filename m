Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVD1Sda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVD1Sda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVD1Sda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:33:30 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:17021 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262219AbVD1SdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:33:12 -0400
Subject: Re: Extremely poor umass transfer rates
From: Mark Rosenstand <mark@ossholes.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050428110614.00a0c193.rddunlap@osdl.org>
References: <1114704142.8410.4.camel@mjollnir.bootless.dk>
	 <20050428165915.GG30768@redhat.com>
	 <1114710941.8326.13.camel@mjollnir.bootless.dk>
	 <20050428110614.00a0c193.rddunlap@osdl.org>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 20:32:59 +0200
Message-Id: <1114713180.8326.22.camel@mjollnir.bootless.dk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 11:06 -0700, Randy.Dunlap wrote:
[snip]
> and post /proc/bus/usb/devices (contents)

See the attached 'devices' file.

Summary:

    T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
    S:  Manufacturer=iriver Limited.
    S:  Product=iriver Internet Audio Player N10

    T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  9 Spd=480 MxCh= 0
    S:  Manufacturer=SanDisk Corp.
    S:  Product=Cruzer Micro

So my mp3 player wasn't USB 2.0. (I told you I wasn't sure.)

I still don't think it should transfer at 20-30 kB/s though, and
certainly not that the keyring (Spd=480) should either. The mp3 player
used to be *much* faster.

-- 
  .-.    Mark Rosenstand        (-.)
  oo|                           cc )
 /`'\    (+45) 255 31337      3-n-(
(\_;/)   mark@geekworld.org    _(|/`->

