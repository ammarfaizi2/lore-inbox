Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267708AbTAHEOt>; Tue, 7 Jan 2003 23:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267706AbTAHEOt>; Tue, 7 Jan 2003 23:14:49 -0500
Received: from magic.adaptec.com ([208.236.45.80]:2488 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id <S267700AbTAHEOs>;
	Tue, 7 Jan 2003 23:14:48 -0500
Date: Tue, 07 Jan 2003 21:23:04 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Tomas Szepe <szepe@pinerecords.com>
cc: dipankar@in.ibm.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: aic7xxx broken in 2.5.53/54 ?
Message-ID: <703940000.1041999784@aslan.btc.adaptec.com>
In-Reply-To: <20030108024107.GA1127@louise.pinerecords.com>
References: <20030103101618.GB8582@in.ibm.com> <596830816.1041606846@aslan.scsiguy.com> <20030106073204.GA1875@in.ibm.com> <274040000.1041869813@aslan.scsiguy.com> <20030108024107.GA1127@louise.pinerecords.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> [gibbs@scsiguy.com]
>> 
>> These reads are actually more expensive than just using PIO.  Neither of
>> these older drivers included a test to try and catch fishy behavior.
> 
> Justin, are you quite sure that these tests actually work?
> I too have just run into

See my recent post to the SCSI list.  The tests don't work on
certain older controllers that lack a feature I was using.  The
latest csets submitted to Linus correct this problem (as verified
on a dusty dual P-90 PCI/EISA box just added to our regression cluster).

--
Justin

