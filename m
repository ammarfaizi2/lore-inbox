Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbRDMP40>; Fri, 13 Apr 2001 11:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbRDMP4Q>; Fri, 13 Apr 2001 11:56:16 -0400
Received: from mercury.ST.HMC.Edu ([134.173.57.219]:13065 "HELO
	mercury.st.hmc.edu") by vger.kernel.org with SMTP
	id <S131457AbRDMP4F>; Fri, 13 Apr 2001 11:56:05 -0400
From: Nate Eldredge <neldredge@hmc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15063.8582.293619.762113@mercury.st.hmc.edu>
Date: Fri, 13 Apr 2001 08:55:50 -0700
To: linux-kernel@vger.kernel.org
CC: lomarcan@tin.it
Subject: Re: SCSI Tape Corruption - update 2
X-Mailer: VM 6.92 under Emacs 20.5.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lomarcan@tin.it wrote:

> Well, the 2.2 distributed with Mandrake 7.2 works fine ... :) 
>
> Hmmm... 32 CONSECUTIVE bytes are a very peculiar error. What can it be? 
>
> Still experimenting...

I once ran into a problem with 32-byte errors appearing in files, and
later, in memory.  I eventually traced it to buggy motherboard cache.
(32 bytes is the size of a cache line.)  A memory tester might be
something to try (I wrote a simple program that seemed to show the
error better than memtest86; can send it if desired.)
 
-- 

Nate Eldredge
neldredge@hmc.edu
