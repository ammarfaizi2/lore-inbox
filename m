Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269769AbUJAMgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269769AbUJAMgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 08:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269771AbUJAMgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 08:36:41 -0400
Received: from mail2.ewetel.de ([212.6.122.16]:65499 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S269769AbUJAMgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 08:36:39 -0400
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc3
In-Reply-To: <2Kmr3-9n-1@gated-at.bofh.it>
References: <2K07b-1Ez-3@gated-at.bofh.it> <2Kh8e-5H2-23@gated-at.bofh.it> <2KjMz-6E6-17@gated-at.bofh.it> <2Kmr3-9n-1@gated-at.bofh.it>
Date: Fri, 1 Oct 2004 14:36:35 +0200
Message-Id: <E1CDMeJ-00005F-Em@localhost>
From: Pascal Schmidt <pascal.schmidt@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2004 05:40:05 +0200, you wrote in linux.kernel:

> Beats me, Clemens.  But at the time, I got curious and the problem was 
> 100% repeatable using the bz2 src code files I had.  The third time I 
> went after the srcs and patches to build that kernel, I got the .gz 
> versions of both, and they worked first time.  Then I went back to 
> the .bz2's and was seeing the same problem as the first 2 downloads 
> gave me.  I mv'd that src file & patch, went after the .bz2's again 
> (for the 3rd time), and that time it worked flawlessly.  Both the 2nd 
> and 3rd dl's files had the exact same md5sum too.  Go figure.

bzip2 stresses the CPU much more than gzip does. Maybe there's
a cooling problem, and of course you won't see error messages when
the CPU starts making mistakes...

-- 
Ciao,
Pascal
