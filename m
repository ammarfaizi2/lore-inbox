Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSEQAEY>; Thu, 16 May 2002 20:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315212AbSEQAEX>; Thu, 16 May 2002 20:04:23 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:48624 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S315213AbSEQAEW>; Thu, 16 May 2002 20:04:22 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15588.18673.317088.198281@wombat.chubb.wattle.id.au>
Date: Fri, 17 May 2002 10:04:01 +1000
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Altaparmakov <aia21@cantab.net>,
        Peter Chubb <peter@chubb.wattle.id.au>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        axboe@suse.de, akpm@zip.com.au, martin@dalecki.de,
        neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <581856778@toto.iv>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:

Daniel> On Tuesday 14 May 2002 03:36, Anton Altaparmakov wrote:
>> ...And yes at the moment the pagecache limit is also a problem
>> which we just ignore in the hope that the kernel will have gone to
>> 64 bits by the time devices grow that large as to start using > 32
>> bits of blocks/pages...

Daniel> PAGE_CACHE_SIZE can also grow, so 32 bit architectures are
Daniel> further away from the page cache limit on than it seems.

Check out the table on page 2 of
http://www.scsita.org/statech/01s005r1.pdf 

The SCSI trade association is predicting 200TB in a high-end server
within 10 years --- and  2TB in a high-end desktop by 2004.  I'd take
some of their predictions with a grain of salt, however.

