Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130879AbRCFCtY>; Mon, 5 Mar 2001 21:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130882AbRCFCtN>; Mon, 5 Mar 2001 21:49:13 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:16351 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130879AbRCFCs6>;
	Mon, 5 Mar 2001 21:48:58 -0500
Message-ID: <3AA45015.4492EC8F@mandrakesoft.com>
Date: Mon, 05 Mar 2001 21:48:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Duane Grigsby <duane.grigsby@qlogic.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel support for hot-plugging  PCI adapters
In-Reply-To: <E2D1ECC3AAFFD411BA8400B0D079EACA5AF215@ntmail.qlc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duane Grigsby wrote:
> Any plans to add support or is there support in the 2.4 kernel for
> hot-plugging a PCI adapter? It may be in the sources already, but I can't
> seem to locate it. Any help would be appreciated.

For devices, the support is already there.  See Documentation/pci.txt. 
Look for 'probe', 'id_table', etc.

I don't think there is support in the current tree for a controller that
supports physical hotplugging of PCI adapters, yet.  Compaq has a driver
outside the tree to do such a thing (needing only very minor kernel
patches), see http://opensource.compaq.com

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
