Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSJYWDv>; Fri, 25 Oct 2002 18:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSJYWDv>; Fri, 25 Oct 2002 18:03:51 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:18190
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261640AbSJYWDt>; Fri, 25 Oct 2002 18:03:49 -0400
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@arcor.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
In-Reply-To: <E185CbL-0008R5-00@starship>
References: <F2DBA543B89AD51184B600508B68D4000ECE7046@fmsmsx103.fm.intel.com>
	<1035584076.13032.96.camel@irongate.swansea.linux.org.uk> 
	<E185CbL-0008R5-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 18:10:09 -0400
Message-Id: <1035583810.1501.4004.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 18:06, Daniel Phillips wrote:

> On Saturday 26 October 2002 00:14, Alan Cox wrote:
>
> > Im just wondering what we would then use to describe a true multiple cpu
> > on a die x86. Im curious what the powerpc people think since they have
> > this kind of stuff - is there a generic terminology they prefer ?
> 
> MIPS also has it, for N=2.

Yep, neat chip :)

POWER4 calls the technology "Chip-Multiprocessing (CMP)" but I have
never seen terminology for referring to the on-core processors
individually.

They do call the SMT units "threads" obviously, however, so if Alan is
OK with it maybe we should go with Jun's opinion and name the field
"thread" ?

	Robert Love


