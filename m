Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316598AbSE0Mz4>; Mon, 27 May 2002 08:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSE0Mzz>; Mon, 27 May 2002 08:55:55 -0400
Received: from mout1.freenet.de ([194.97.50.132]:52888 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S316598AbSE0Mzz>;
	Mon, 27 May 2002 08:55:55 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: Memory management in Kernel 2.4.x
Date: Mon, 27 May 2002 14:58:27 +0200
Organization: Privat
Message-ID: <actahk$6bp$1@ID-44327.news.dfncis.de>
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <fa.na0lviv.e2a93a@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1022504308 6521 192.168.1.3 (27 May 2002 12:58:28 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.1
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> On Mon, 27 May 2002, Andreas Hartmann wrote:
> 
>> rsync allocates all of the memory the machine has (256 MB RAM, 128 MB
>> swap). When this occures, processes get killed like described in the
>> posting before. The machine doesn't respond as long as the rsync -
>> process isn't killed, because it fetches all the memory which gets free
>> after a process has been killed.
> 
> And the rsync process never gets singled out? nice!

Until it's killed by the kernel (if overcommitment isn't deactivated). If 
overcommitment is deactivated, the services of the machine are dead 
forever. There will be nothing, which kills such a process. Or am I wrong?


Regards,
Andreas Hartmann
