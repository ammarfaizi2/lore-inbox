Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbTCFHvf>; Thu, 6 Mar 2003 02:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267892AbTCFHvf>; Thu, 6 Mar 2003 02:51:35 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:2637
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267886AbTCFHvd>; Thu, 6 Mar 2003 02:51:33 -0500
Date: Thu, 6 Mar 2003 02:59:45 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mike Anderson <andmike@us.ibm.com>
cc: Andries.Brouwer@cwi.nl, "" <torvalds@transmeta.com>,
       "" <linux-kernel@vger.kernel.org>, "" <linux-scsi@vger.kernel.org>
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
In-Reply-To: <20030306064921.GA1425@beaverton.ibm.com>
Message-ID: <Pine.LNX.4.50.0303060256200.25282-100000@montezuma.mastecende.com>
References: <UTC200303060639.h266dIo22884.aeb@smtp.cwi.nl>
 <20030306064921.GA1425@beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003, Mike Anderson wrote:

> Andries.Brouwer@cwi.nl [Andries.Brouwer@cwi.nl] wrote:
> > > See if this fixes it..
> > 
> > No, I am afraid not. My infinite loop does not pass through
> > scsi_eh_ready_devs().
> > 
> 
> Can you send me your console log. If you have scsi_logging=1 that would
> be greate also.

If you can figure out which paths this goes through because it completely 
locks up right before printing 'scsi: device offlined' on 2.5.63. I 
can't provide much more information at present.

scsi1 : QLogic ISP1020 SCSI on PCI bus 04 device 70 irq 89 MEM base 0xf8a18000
scsi: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 0 lun 0
scsi: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 1 lun 0

	Zwane
-- 
function.linuxpower.ca
