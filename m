Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbSIRQ1g>; Wed, 18 Sep 2002 12:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267302AbSIRQ1f>; Wed, 18 Sep 2002 12:27:35 -0400
Received: from packet.digeo.com ([12.110.80.53]:19950 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267300AbSIRQ1e>;
	Wed, 18 Sep 2002 12:27:34 -0400
Message-ID: <3D88AA9D.6CE61435@digeo.com>
Date: Wed, 18 Sep 2002 09:32:29 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: axel@hh59.org
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.36: PCI: Unable to reserve I/O region
References: <20020918162523.GA204@prester.hh59.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Sep 2002 16:32:29.0416 (UTC) FILETIME=[FB034680:01C25F30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

axel@hh59.org wrote:
> 
> Hi,
> 
> just booted 2.5.36-mm1. The following part from dmesg appeared a little
> strange or rather wrong to me. The systems runs fine as far as I can see.
> 
> ide1 at 0x170-0x177,0x376 on irq 15
> ICH: IDE controller at PCI slot 00:1f.1
> PCI: Unable to reserve I/O region #5:10@f000 for device 00:1f.1
> ICH: not 100% native mode: will probe irqs later
> ICH: port 0x01f0 already claimed by ide0
> ICH: port 0x0170 already claimed by ide1
> ICH: neither IDE port enabled (BIOS)
> 
> Are these messages bad?
> 

I get them too.  Part of the recent IDE changes.  Apparently
they are expected, and OK.
