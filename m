Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbSIRLno>; Wed, 18 Sep 2002 07:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266164AbSIRLno>; Wed, 18 Sep 2002 07:43:44 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:38099 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S266161AbSIRLnn>; Wed, 18 Sep 2002 07:43:43 -0400
Message-ID: <3D8867E7.4010107@quark.didntduck.org>
Date: Wed, 18 Sep 2002 07:47:51 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Ole_Andr=E9_Vadla_Ravn=E5s?= 
	<oleavr-lkml@jblinux.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Virtual to physical address mapping
References: <1032328456.5812.16.camel@zole.jblinux.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ole André Vadla Ravnås wrote:
> Hi
> 
> I've noticed that ifconfig shows a base address and an interrupt
> number.. However, I can't get that base address to correspond to
> anything in /proc/iomem, which means that I can't determine which PCI
> device (in this case) it corresponds to (guess the base address is
> virtual). What I want is to find a way to get the PCI bus and device no
> for the network device, but is this at all possible without altering the
> kernel?
> 
> Ole André

It's in /proc/ioports

--
				Brian Gerst


