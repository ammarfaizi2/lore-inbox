Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278450AbRLDBWF>; Mon, 3 Dec 2001 20:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284831AbRLDAUy>; Mon, 3 Dec 2001 19:20:54 -0500
Received: from leeloo.zip.com.au ([203.12.97.48]:20236 "EHLO
	mangalore.zipworld.com.au") by vger.kernel.org with ESMTP
	id <S284834AbRLDAR5>; Mon, 3 Dec 2001 19:17:57 -0500
Message-ID: <3C0C1628.5D73F05A@zip.com.au>
Date: Mon, 03 Dec 2001 16:17:44 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan-Hendrik Palic <jan.palic@linux-debian.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: EXT3 - freeze ups during disk writes
In-Reply-To: <Pine.LNX.4.33.0112011209190.3893-100000@localhost.localdomain> <E16AX5E-0006pH-00@calista.inka.de>,
			<E16AX5E-0006pH-00@calista.inka.de> <20011203085258.A4072@billgotchy.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Hendrik Palic wrote:
> 
> The IBook freezed and I reseted it .. but I had to install the whole
> system .. the yaboot wasn't able to find a kernel on the / Partition.
> (ext3 too) :)
> 

An unrecovered ext3 filesystem is probably unrecognisable to
yaboot.  I'm told that yaboot 1.3.5 and later have changes which
permit booting from unrecovered ext3 filesystems.
