Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266738AbRGORyn>; Sun, 15 Jul 2001 13:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266746AbRGORyc>; Sun, 15 Jul 2001 13:54:32 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:17680 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266738AbRGORyS>; Sun, 15 Jul 2001 13:54:18 -0400
Message-ID: <3B51D8C8.89F57EBF@namesys.com>
Date: Sun, 15 Jul 2001 21:54:16 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: volodya@mindspring.com, Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <E15Lp2T-0004DQ-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > Ext2 handles files larger than 2Gb, and can handle up to about 1Tb per volume
> > > which is the block layer fs size limit.
> > >
> > The limits for reiserfs and ext2 for kernels 2.4.x are the same (and they are 2Tb not 1Tb).  The
> > limits are not in the individual filesystems.  We need to have Linux go to 64 bit blocknumbers in
> 
> Its 1 terabyte - there are some unclean sign bit abuses

but for some servers that bigstorage.com ships, using some drivers, 2Tb works...:-)
Ok, the limit is 1-2TB, depending, yes?

Hans
