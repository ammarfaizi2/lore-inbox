Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132844AbRDXHeX>; Tue, 24 Apr 2001 03:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132852AbRDXHeD>; Tue, 24 Apr 2001 03:34:03 -0400
Received: from smtp.mountain.net ([198.77.1.35]:16133 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S132844AbRDXHdw>;
	Tue, 24 Apr 2001 03:33:52 -0400
Message-ID: <3AE52C2C.C6B2B472@mountain.net>
Date: Tue, 24 Apr 2001 03:33:00 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
CC: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Semi-OT] Dual Athlon support in kernel
In-Reply-To: <Pine.LNX.4.33.0104240115050.21785-100000@asdf.capslock.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mike A. Harris" wrote:
> 
> Would the current state of athlon support be considered stable?
> I've got a colleague interested in getting a dual athlon box, and
> I'll be making the decision as to what hardware to purchase.  I'm
> wondering is dual Athlon viable for a business solution right
> now, or is it considered "experimental"?
> 
> What hardware would be recommended for a dual CPU system that
> needs to be fairly rock solid?  Should I recommend to stay with
> the P-III Xeon?  Or something else?  What issues would I expect
> to have to deal with if going with a dual Athlon?
> 
> Also, what is a good rock solid SCSI RAID controller?  Money is
> no object.  Reliability, performance and Linux compatibility are
> though.
> 
> Chipsets to avoid?
> 
> Any experiences/info good/bad would be greatly appreciated.

The build problen with Athlon+SMP was solved by AA's patch. I had tested a
similar patch on UP over 2.4.0-test and previous 2.4 releases with nary a
problem.

This may be too experimental for your purposes, but FWIW I'm writing from a
2.4.4-pre3 built with gcc-2.97-20010205 using -march=athlon set by the k7
config. I've been building kernels with that snapshot since the middle of
Feb. With the current image, the box has locked up once in continuous use. I
can't say what caused that one, no log survived. 

Cheers,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
