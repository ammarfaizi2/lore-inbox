Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266507AbSLDNXT>; Wed, 4 Dec 2002 08:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266512AbSLDNXT>; Wed, 4 Dec 2002 08:23:19 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:10149 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266507AbSLDNXT>; Wed, 4 Dec 2002 08:23:19 -0500
Subject: Re: timer glitch (solved?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felipe Massia <felmasper@yahoo.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021204045258.590d7732.felmasper@yahoo.com.br>
References: <20021204045258.590d7732.felmasper@yahoo.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 14:05:16 +0000
Message-Id: <1039010716.15353.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 06:52, Felipe Massia wrote:
> My clock, some times, gives wrong results. When I call the folowing
> command
> 
>   bash$ while : ; do date ; done
> 
> the time shown is not correct. When the seconds are changing, for a

There are some changes cooking in the 2.5 stream that may help and if so
should get backported

