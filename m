Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262915AbSJAXAw>; Tue, 1 Oct 2002 19:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262947AbSJAXAw>; Tue, 1 Oct 2002 19:00:52 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:12791 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S262915AbSJAXAv>; Tue, 1 Oct 2002 19:00:51 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15770.10847.884743.30282@wombat.chubb.wattle.id.au>
Date: Wed, 2 Oct 2002 09:06:07 +1000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
In-Reply-To: <96096729@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Tue, Oct 01, 2002 at 12:32:47AM -0700, Linus Torvalds
Christoph> wrote:
>> you _should_ also test this code out even before the freeze. The
>> IDE layer shouldn't be all that scary any more, and while there are
>> still silly things like trivially non-compiling setups etc, it's
>> generally a good idea to try things out as widely as possible
>> before it's getting too late to complain about things..

Christoph> What about the 64bit sector_t (aka >2TB blockdevice)
Christoph> patches.  IMHO they're a must-have for 2.6 (people already
Christoph> ask for backporting them to 2.4..) and last time I check
Christoph> Peter had a BK tree with nicely split changesets.



Indeed...  And I'm trying to merge it all now into 2.5.40.  Sorry I've
been a bit slow --- testing, especially error testing when disks fill
up, takes a long time  (How long does it take to write 4 TB to a disk?
About a day with the machines I have here.  Multiply that by three 
(now four with XFS) filesystems to test...) 

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
