Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSJEAjR>; Fri, 4 Oct 2002 20:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261917AbSJEAjR>; Fri, 4 Oct 2002 20:39:17 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:14322 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261914AbSJEAjQ>; Fri, 4 Oct 2002 20:39:16 -0400
Subject: Re: [RFC][PATCH] HZ as a config option
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D9E1BEA.7060804@us.ibm.com>
References: <3D9E1BEA.7060804@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 01:53:16 +0100
Message-Id: <1033779196.1335.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 23:53, Dave Hansen wrote:
> On large systems (like NUMA-Q, Intel Profusion, etc...), latency and 
> user responsiveness become much less important.  The extra scheduling 
> overhead caused by higher HZ is bad.
> 
> This is x86-only right now.  Is there any wider desire to tune this at 
> config time?  Do any architecutures have strict rules as to what this 
> can be set to?

You can't set this arbitarily, the NTP PLL's will only lock for certain
value ranges.

