Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbRGEVVg>; Thu, 5 Jul 2001 17:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263793AbRGEVV0>; Thu, 5 Jul 2001 17:21:26 -0400
Received: from eagle.physics.drexel.edu ([129.25.7.156]:2830 "EHLO
	eagle.physics.drexel.edu") by vger.kernel.org with ESMTP
	id <S263149AbRGEVVS>; Thu, 5 Jul 2001 17:21:18 -0400
Message-ID: <3B44DA51.10D3F0C0@newton.physics.drexel.edu>
Date: Thu, 05 Jul 2001 17:21:21 -0400
From: "Ernest N. Mamikonyan" <ernest@newton.physics.drexel.edu>
Organization: Department of Physics, Drexel University
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: increasing the TASK_SIZE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering how I can increase the process address space, TASK_SIZE
(PAGE_OFFSET), in the current kernel. It looks like the 3 GB value is
hardcoded in a couple of places and is thus not trivial to alter. Is
there any good reason to limit this value at all, why not just have it
be the same as the max addressable space (64 GB)? We have an ix86 SMP
box with 4 GB of RAM and want to be able to allocate all of it to a
single program (physics simulation). I would greatly appreciate any help
on this.


Thanks a great deal,
Ernie

PS. Please `CC' me the answer!

/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
Ernest N. Mamikonyan     E-Mail: ernest@newton.physics.drexel.edu
Department of Physics,   Phone: (215) 895-1544
Drexel University        Fax: (215) 895-5934
Philadelphia, PA  19104  Web: www.physics.drexel.edu/research/astro
/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
