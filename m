Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266556AbTGKAAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269722AbTGKAAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:00:19 -0400
Received: from storm.he.net ([64.71.150.66]:13453 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S266556AbTGKAAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:00:14 -0400
Date: Thu, 10 Jul 2003 17:12:53 -0700
From: Greg KH <greg@kroah.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: John Wong <kernel@implode.net>, linux-kernel@vger.kernel.org
Subject: Re: USB stops working with any of 2.4.22-pre's after 2.4.21
Message-ID: <20030711001253.GB15317@kroah.com>
References: <20030710065801.GA351@gambit.implode.net> <200307101335.34266.gene.heskett@verizon.net> <20030710175045.GA12533@kroah.com> <200307101851.14757.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307101851.14757.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 06:51:14PM -0400, Gene Heskett wrote:
> 
> T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=1453 ProdID=4026 Rev= 0.00
> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=serial
> E:  Ad=81(I) Atr=03(Int.) MxPS=  10 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

Looks ok, the device probably just doesn't have any string descriptors
(or any valid ones at least.)

It should not affect the operation of the device, right?

greg k-h
