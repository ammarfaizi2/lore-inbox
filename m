Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSFKDuP>; Mon, 10 Jun 2002 23:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSFKDuP>; Mon, 10 Jun 2002 23:50:15 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:56518 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S316682AbSFKDuN>; Mon, 10 Jun 2002 23:50:13 -0400
Date: Mon, 10 Jun 2002 20:46:21 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: BALBIR SINGH <balbir.singh@wipro.com>
cc: "'Bill Davidsen'" <davidsen@tmr.com>,
        "'Olivier Galibert'" <galibert@pobox.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: MTU discovery
In-Reply-To: <039d01c210f8$83fa54b0$290806c0@wipro.com>
Message-ID: <Pine.LNX.4.44.0206102045310.7028-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

does ieee 802.3z specify a standard? I don;t have a copy handy.

joelja

On Tue, 11 Jun 2002, BALBIR SINGH wrote:

> Actually not, the Intel driver/card supports a size of
> 
> look into e1000_mac.h
> 
> #define MAX_JUMBO_FRAME_SIZE         0x3F00 (which is  16128).
> 
> The bottom line is 9000 is not the limit, it is
> just the beginning of jumbo frame sizes.
> 
> Balbir
> 
> |-----Original Message-----
> |From: linux-kernel-owner@vger.kernel.org 
> |[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Joel Jaeggli
> |Sent: Tuesday, June 11, 2002 3:32 AM
> |To: Bill Davidsen
> |Cc: Olivier Galibert; linux-kernel@vger.kernel.org
> |Subject: Re: MTU discovery
> |
> |
> |
> |9000 is the limit on gigabit ethernet, other media type have different 
> |maximum frame sizes (ie 4470 on fddi, 9216 on pos oc12 interfaces). 
> |
> 
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


