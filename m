Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbTBBIkB>; Sun, 2 Feb 2003 03:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTBBIkA>; Sun, 2 Feb 2003 03:40:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57998
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265154AbTBBIj5>; Sun, 2 Feb 2003 03:39:57 -0500
Subject: Re: [PCMCIA] [IDE] [2.5.59-mm7] Badness in  kobject_register call
	trace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200302012325.07397.cb-lkml@fish.zetnet.co.uk>
References: <200302012325.07397.cb-lkml@fish.zetnet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044179118.16853.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 02 Feb 2003 09:45:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-01 at 23:25, Charles Baylis wrote:
> On inserting a PCMCIA compact flash adapter, I get this backtrace. I presume 
> this fits in the "yes, 2.5 IDE isn't finished yet" category. Other 
> information available on request.

Badness in kobject_register is something that whoever did kobject stuff for
IDE broke. Its not a change done by the IDE people. Hopefully whoever did
the kobject stuff will fix it

As to the IDE side, idecs is a bit iffy in 2.5. 

Alan

