Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273723AbRJFLiq>; Sat, 6 Oct 2001 07:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274064AbRJFLig>; Sat, 6 Oct 2001 07:38:36 -0400
Received: from mail1.svr.pol.co.uk ([195.92.193.18]:30504 "EHLO
	mail1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S273723AbRJFLiZ>; Sat, 6 Oct 2001 07:38:25 -0400
Message-ID: <3BBEED4A.6030009@humboldt.co.uk>
Date: Sat, 06 Oct 2001 12:38:50 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Ebling <kernelhacker@lineone.net>
CC: adam.keys@HOTARD.engr.smu.edu, linux-kernel@vger.kernel.org
Subject: Re: Development Setups
In-Reply-To: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there> <1002302124.1034.5.camel@kernighan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Ebling wrote:


> Feedback on this document from anyone would be very much appreciated
> from anyone :)


The only thing I'd add is some pointers to setting up the target box 
with NFS root. In my setup for driver development both my x86 and ppc 
target boxes are diskless. The x86 boots using etherboot on a floppy, 
and the ppc has network booting in the rom.  I just compile a new kernel 
on the development box, copy it into my /tftpboot directory, and hit the 
reset button on the target. No mess, no fuss, no fsck.

-- 
Adrian Cox   http://www.humboldt.co.uk/

