Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSKUTvj>; Thu, 21 Nov 2002 14:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266953AbSKUTvj>; Thu, 21 Nov 2002 14:51:39 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:8328 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264818AbSKUTvi>; Thu, 21 Nov 2002 14:51:38 -0500
Subject: Re: [RFC] [PATCH] subarch cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: john stultz <johnstul@us.ibm.com>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20021121191506.GA2007@mars.ravnborg.org>
References: <1037750429.4463.71.camel@w-jstultz2.beaverton.ibm.com>
	<20021121183304.GA1144@mars.ravnborg.org>
	<1037904954.7576.62.camel@w-jstultz2.beaverton.ibm.com> 
	<20021121191506.GA2007@mars.ravnborg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 20:27:15 +0000
Message-Id: <1037910436.7687.78.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 19:15, Sam Ravnborg wrote:
> mflags-$(CONFIG_MACH_VISWS)      := asm/mach-visws
> mflags-$(CONFIG_MACH_SUMMIT)     := asm/mach-summit
> mflags-y                         += asm/mach-generic
> AFLAGS += $(mflags-y)
> CFLAGS += $(mflags-y)
> 
> There is something similar done for arm in newest kernel.

-ac already does this for include's so that mach-default is used if the
system doesnt override it

