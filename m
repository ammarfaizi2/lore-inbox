Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271945AbRH2LOa>; Wed, 29 Aug 2001 07:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271946AbRH2LOL>; Wed, 29 Aug 2001 07:14:11 -0400
Received: from thunderchild.ikk.sztaki.hu ([193.225.87.24]:54277 "HELO
	thunderchild.ikk.sztaki.hu") by vger.kernel.org with SMTP
	id <S271945AbRH2LOC>; Wed, 29 Aug 2001 07:14:02 -0400
Date: Wed, 29 Aug 2001 13:14:19 +0200
From: Gergely Madarasz <gorgo@thunderchild.debian.net>
To: linux-kernel@vger.kernel.org
Subject: vm problems
Message-ID: <20010829131419.Z6202@thunderchild.ikk.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get hundreds of this error message:

__alloc_pages: 0-order allocation failed.

The machine is an IBM x250 with 4G ram, the kernel is vanilla 2.4.9 and
2.4.9-ac3, no swap, running bonnie++. When the memory fills up with cache,
I start receiving the error message. 

             total       used       free     shared    buffers     cached
Mem:       3863628    3854532       9096          0       5160    3734832
-/+ buffers/cache:     114540    3749088
Swap:            0          0          0

-- 
Madarasz Gergely   gorgo@thunderchild.debian.net   gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
                  HuLUG: http://mlf.linux.rulez.org/
