Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291935AbSBATrB>; Fri, 1 Feb 2002 14:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291947AbSBATq4>; Fri, 1 Feb 2002 14:46:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61961 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291935AbSBATpo>; Fri, 1 Feb 2002 14:45:44 -0500
Subject: Re: should I trust 'free' or 'top'?
To: adam-dated-1013023458.e87e05@flounder.net (Adam McKenna)
Date: Fri, 1 Feb 2002 19:58:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020201192415.GC23997@flounder.net> from "Adam McKenna" at Feb 01, 2002 11:24:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Wjpi-0005w7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> processes and swapping, enough that I feel compelled to report them here.  We
> have tried all different kernels from 2.4.6 to 2.4.16, and the problem seems
> to happen with all of them (but is more pronounced on certain kernels)

The only kernels you are likely to see that not happen on are

-	The 2.4.9 kernel with Rik's patches that Linus didnt take
	(Red Hat 2.4.9-*)
-	2.4.17/18pre with the rmap11/rmap12 patches
-	2.4.17/18pre with the -aa patched VM
	(which I believe is also in the SuSE kernel packages)
-	2.2

The base VM in Linus tree has been broken since before 2.4.0 and while
somewhat better is still that - broken. The major vendors don't ship it for
a reason.

Alan
