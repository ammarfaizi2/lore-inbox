Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSGAUur>; Mon, 1 Jul 2002 16:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSGAUuq>; Mon, 1 Jul 2002 16:50:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35589 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316503AbSGAUup>;
	Mon, 1 Jul 2002 16:50:45 -0400
Message-ID: <3D20C0C4.E7C6AECA@zip.com.au>
Date: Mon, 01 Jul 2002 13:51:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@broadpark.no>
CC: davej@suse.de, Helge Hafting <helgehaf@aitel.hist.no>,
       linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: [Fwd: Re: 2.5.24-dj1,smp,ext2,raid0: I got random zero blocks in my 
 files.]
References: <3D20539F.C7D7A4C4@aitel.hist.no> <3D20B29B.ED186C3B@broadpark.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> ..
> I got lots of these,
> monster kernel: raid0_make_request bug: can't convert block across
> chunks or bigger than 32k 2944376 32
> 

You may have to drop back to 4k in that case.

-
