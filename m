Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281009AbRLGNnK>; Fri, 7 Dec 2001 08:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281217AbRLGNmy>; Fri, 7 Dec 2001 08:42:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26122 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281009AbRLGNmR>; Fri, 7 Dec 2001 08:42:17 -0500
Subject: Re: Kernel freezing....
To: jcarminati@yahoo.com (Jorge Carminati)
Date: Fri, 7 Dec 2001 13:51:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011207133020.41163.qmail@web13905.mail.yahoo.com> from "Jorge Carminati" at Dec 07, 2001 05:30:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E16CLPT-0005sN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In all the cases the compiled kernel had set exactly the same options,
> **just changed the cpu optimization type**. Kernel version 2.4.16.
> 
> Conclusion: IMHO it´s a kernel bug. The same .config optimized for AMD
> freezes, and Red Hat's default kernel does the same. Luckily for my
> investment it´s not a memory bug.

The AMD K7 stuff will trigger hardware bugs on some VIA boards. We know
that bit. Why the RH one crashes may be that or may be a different bug
fixed between 2.4.9->16. 

Either way this is good news. The machine seems fine and the newer kernel
seems to be behaving well.

Alan
