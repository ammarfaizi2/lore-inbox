Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319229AbSIFRBb>; Fri, 6 Sep 2002 13:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319233AbSIFRBb>; Fri, 6 Sep 2002 13:01:31 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:50677
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319229AbSIFRBa>; Fri, 6 Sep 2002 13:01:30 -0400
Subject: Re: Linux SMP kernel bug with > 512M ram
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jeff@AmeriCom.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020906165516.17282.qmail@solo.americom.com>
References: <20020906165516.17282.qmail@solo.americom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 18:07:08 +0100
Message-Id: <1031332028.9945.74.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 17:55, jeff@AmeriCom.com wrote:
> I've been having problems with a few of our servers and I can't seem to find this 
> problem mentioned anywhere else. All of the dual processor machines will not operate 
> with greater than 512 megs of ram with the newer SMP kernels (2.4.7-10enterprise #1 

2.4.7 is hardly "new". Red Hat has issued errata kernels going up to
2.4.9.

> SMP). Two of the dual P3 1ghz machines crash after a few minutes, when the memory 
> usage gets high enough, I presume. The errors they spit out vary, but its only when 
> I go over 512megs of ram, and only on dual processor machines. I had a slightly 

Chipset or memory hardware problems seem the most likely cause if the
errors seem random or weird

> different problem when I tried to set it up on a dual p2 266 machine, when I go over 
> 512 megs there, the system takes an hour to boot up, and everything crawls from 

Thats BIOS. Thats a well known BIOS problem where the BIOS doesnt
configure the mtrr registers properly. You can work around that one by
tweaking the settings by hand or probably by getting a newer BIOS 


