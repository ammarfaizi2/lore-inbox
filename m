Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSILPxN>; Thu, 12 Sep 2002 11:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSILPxM>; Thu, 12 Sep 2002 11:53:12 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:2038 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316235AbSILPxM>; Thu, 12 Sep 2002 11:53:12 -0400
Subject: Re: unexpected IO-APIC on IBM xSeries 440
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mzielinski@wp-sa.pl
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209121733.28871.mzielinski@wp-sa.pl>
References: <200209121733.28871.mzielinski@wp-sa.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 12 Sep 2002 16:58:29 +0100
Message-Id: <1031846309.2838.96.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 16:33, Mariusz Zielinski wrote:
> Hi list,
> as instructed I'm making contact (attached dmesg). IBM claims that machine
> is supported under linux (RedHat Advanced Server 2.1) but I couldn't find any 
> patches. Is it possible that RedHat is hiding some patches from linux 
> community? :)

Hardly. The patches for pretty much every vendor tree are neatly broken
down at http://www.kernelnewbies.org/

> 
> The problem is that /proc/cpuinfo shows at most 4 processors (depending on 
> kernel version). Dmesg shows many  "APIC error on CPUx: 00(80)" errors.
> I can provide you with further details (make some tests) if needed. 

I don't know what state 2.5 is on Summit numa but 2.4.19-ac and
2.4.20pre6 plus one patch (I can bounce you the diff if you want) should
work nicely on summit chipsets with any distro

