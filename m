Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268986AbTBZV7c>; Wed, 26 Feb 2003 16:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268982AbTBZV7b>; Wed, 26 Feb 2003 16:59:31 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50940 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268986AbTBZV73>; Wed, 26 Feb 2003 16:59:29 -0500
Date: Wed, 26 Feb 2003 23:09:36 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linstab@osdl.org
Subject: Re: 2.5 porting items
Message-ID: <20030226220936.GN7685@fs.tum.de>
References: <1046221420.20288.17.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046221420.20288.17.camel@cherrytest.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please add the following #error's to your list:

net/defxx.c:#error Please convert me to Documentation/DMA-mapping.txt
net/rcpci45.c:#error Please convert me to Documentation/DMA-mapping.txt
scsi/pci2220i.c:#error Convert me to understand page+offset based scatterlists
scsi/scsiiom.c:#error Please convert me to Documentation/DMA-mapping.txt
scsi/ini9100u.c:#error Please convert me to Documentation/DMA-mapping.txt
scsi/AM53C974.c:#error Please convert me to Documentation/DMA-mapping.txt
scsi/dpt_i2o.c:#error Please convert me to Documentation/DMA-mapping.txt


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

