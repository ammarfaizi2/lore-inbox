Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317465AbSFRQE6>; Tue, 18 Jun 2002 12:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSFRQE5>; Tue, 18 Jun 2002 12:04:57 -0400
Received: from rrcs-sw-24-153-135-82.biz.rr.com ([24.153.135.82]:52418 "HELO
	UberGeek") by vger.kernel.org with SMTP id <S317465AbSFRQEz>;
	Tue, 18 Jun 2002 12:04:55 -0400
Subject: Re: VMM - freeing up swap space
From: Austin Gonyou <austin@digitalroadkill.net>
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: "Linux Kernel \(E-mail\)" <linux-kernel@vger.kernel.org>
In-Reply-To: <EE83E551E08D1D43AD52D50B9F5110927E7A9E@ntserver2>
References: <EE83E551E08D1D43AD52D50B9F5110927E7A9E@ntserver2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 18 Jun 2002 11:04:51 -0500
Message-Id: <1024416291.7689.34.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The -AA kernels have fixes for this so it actually reclaims the swap and
*cached* memory as well. 

On Tue, 2002-06-18 at 10:56, Gregory Giguashvili wrote:
> Hello,
> 
> Running an application allocating huge amounts of memory would push some
> data from RAM to swap area. After the application terminates, swap area is
> usually still occupied. 
> 
> Is there any way to clean up the swap area by pushing the data back to RAM?
> 
> Thanks in advance
> Giga
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Gregory Giguashvili
> Senior Software Engineer
> Email: gregoryg@ParadigmGeo.com
> Tel: 972-9-9709379 Fax: 972-3-9709337
> Paradigm Geophysical Ltd.
> http://www.math.tau.ac.il/~gregoryg
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
