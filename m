Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267927AbTAMOGs>; Mon, 13 Jan 2003 09:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267926AbTAMOGs>; Mon, 13 Jan 2003 09:06:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10904
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267927AbTAMOGr>; Mon, 13 Jan 2003 09:06:47 -0500
Subject: Re: ide-scsi bug hard locks machine
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jason Thomas <jason@topic.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030113030749.GC626@topic.com.au>
References: <20030113030749.GC626@topic.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042470172.18624.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 13 Jan 2003 15:02:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 03:07, Jason Thomas wrote:
> ide-scsi: abort called for 2
> bad: scheduling while atomic!
> Call Trace: [<c0116941>]  [<c0109b76>]  [<c01169b0>]  [<c011a5db>]  [<c0109d8c>]  [<c0263100>]  [<c0262730>]  [<c026848c>]  [<c0268390>]  [<c0261e63>]  [<c0261cc0>]  [<c0261c80>]  [<c026225d>]  [<c02622d7>]  [<c0262b65>]  [<c0109d97>]  [<c0262c89>]  [<c0262bb0>]  [<c0108be9>] 
> hde: lost interrupt
> ide-scsi: CoD != 0 in idescsi_pc_intr
> hde: ATAPI reset complete
> hde: irq timeout: status=0xc0 { Busy }
> hde: ATAPI reset complete
> hde: irq timeout: status=0xc0 { Busy }
> hde: ATAPI reset complete
> hde: irq timeout: status=0xc0 { Busy }
> ide-scsi: reset called for 2

Someone broke ide-scsi in 2.5. I've not had time to investigate why yet. If you 
need ide-scsi use 2.4.

