Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbTC3PrF>; Sun, 30 Mar 2003 10:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbTC3PrF>; Sun, 30 Mar 2003 10:47:05 -0500
Received: from [81.2.110.254] ([81.2.110.254]:43765 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261389AbTC3PrF>;
	Sun, 30 Mar 2003 10:47:05 -0500
Subject: Re: Re[2]: 845GE Chipset severe performance problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Craig Robinson <craig.robinson@btinternet.com>
Cc: linux-kernel-owner@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <153495685337.20030329170457@btinternet.com>
References: <188481168784.20030329130300@btinternet.com>
	 <1048949147.6725.3.camel@dhcp22.swansea.linux.org.uk>
	 <153495685337.20030329170457@btinternet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049039985.14686.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 30 Mar 2003 16:59:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 17:04, Craig Robinson wrote:
>  [/usr/src]# cat /proc/mtrr
> reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
> reg01: base=0x10000000 ( 256MB), size= 128MB: write-back, count=1
> reg02: base=0x18000000 ( 384MB), size=  64MB: write-back, count=1
> reg03: base=0x1c000000 ( 448MB), size=  32MB: write-back, count=1
> reg04: base=0x1e000000 ( 480MB), size=  16MB: write-back, count=1
> reg05: base=0x1f000000 ( 496MB), size=   8MB: write-back, count=1

Looks right for a machine with 504Mb of RAM. How does your box run
if you boot with mem=504M ?

