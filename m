Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316084AbSETP00>; Mon, 20 May 2002 11:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316083AbSETP0Z>; Mon, 20 May 2002 11:26:25 -0400
Received: from 209-6-202-152.c3-0.nwt-ubr1.sbo-nwt.ma.cable.rcn.com ([209.6.202.152]:33780
	"EHLO chezrutt.dyndns.org") by vger.kernel.org with ESMTP
	id <S316082AbSETP0Y>; Mon, 20 May 2002 11:26:24 -0400
From: John Ruttenberg <rutt@chezrutt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15593.5530.966736.798235@localhost.localdomain>
Date: Mon, 20 May 2002 11:26:18 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Dell Inspiron i8100 with 2 batteries  [Solved!]
In-Reply-To: <19261.1021724437@redhat.com>
X-Mailer: VM 6.96 under Emacs 20.7.1
Reply-to: rutt@chezrutt.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Lehmann suggested downgrading to Dell's A7 bios and it fixed this problem
(along with some minor stuff with the i8k fan/temperature control stuff.
(Fans no longer go through speed 2 to get to speed 1).  I am also hoping that
it will result in better clock accuracy (I read some posting about this), but
my experiments with this aren't complete.

David Woodhouse:
> 
> dave@AFRInc.com said:
> >  I've got the same laptop with one battery, but I'm using ACPI. None
> > of the current user-space utilities parse this stuff particularly well
> > (the filenames in /proc/acpi have changed), but the data all look
> > reasonable. 
> 
> Those data also come straight from the BIOS. The ACPI code on those laptops 
> is all just traps into the SMM BIOS. I'd guess it's running exactly the 
> same code inside.
> 
> --
> dwmw2
