Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267647AbTBFWJd>; Thu, 6 Feb 2003 17:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267649AbTBFWJd>; Thu, 6 Feb 2003 17:09:33 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24737
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267647AbTBFWJc>; Thu, 6 Feb 2003 17:09:32 -0500
Subject: Re: 2.5.59 kernel bugs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: niteowl@intrinsity.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <267250000.1044565727@[10.10.2.4]>
References: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com>
	 <267250000.1044565727@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044573413.12098.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Feb 2003 23:16:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 21:08, Martin J. Bligh wrote:
> Some fairly sickening stuff ... I'll log the following sections in bugzilla
> If any brave volunteers for the others want to go ahead with the other
> sections, and split the effort, would be much appreciated. Please mail
> back to lkml that you're doing it ... and watch very carefully on newly
> logged bugs for collisions ;-)

2.4-ac fixes applied for :  (No name in the entry as I've not figured
out who to credit yet)

o       Fix i2c_ack cris extra ";"
o       Fix JSIOCSBTNMAP extra ";"
o       Fix VIDIOCGTUNER on w9966
o       Fix amd8111e_read_regs
o       Fix smctr_load_node_addr
o       Fix sym53c8xxx extra ";"
o       Fix sym53c8xxx_2 extra ";"
o       Fix cs46xx download area clear
o       Fix hysdn bootup error handling
o       Fix mtd mount error checks
o       Fix dpt_i2o reset error paths
o       Fix a jffs error path handler
o       Fix es1371 error path on register
o       Fix sscape operator precedence
o       Fix copy counting in vrc5477 audio

Once the next -ac appears those should all drop into 2.5 if someone 
wants to do the legwork



