Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314964AbSEBS0N>; Thu, 2 May 2002 14:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315227AbSEBS0M>; Thu, 2 May 2002 14:26:12 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:12811 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314964AbSEBS0L>; Thu, 2 May 2002 14:26:11 -0400
Message-ID: <3CD184BB.ED7F349F@linux-m68k.org>
Date: Thu, 02 May 2002 20:26:03 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andrea Arcangeli <andrea@suse.de>, Ralf Baechle <ralf@uni-koblenz.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: discontiguous memory platforms
In-Reply-To: <Pine.LNX.4.21.0205021539460.23113-100000@serv> <E172umC-0001zd-00@starship> <3CD17DCE.B7DB465D@linux-m68k.org> <E172yOR-00026G-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Daniel Phillips wrote:

> > Most of the time there are only a few nodes, I just don't know where and
> > how big they are, so I don't think a hash based approach will be a lot
> > faster. When I'm going to change this, I'd rather try the dynamic table
> > approach.
> 
> Which dynamic table approach is that?

I mean calculating the lookup table and patching the kernel at startup.
Anyway, I agree with Andrea, that another mapping isn't really needed.
Clever use of the mmu should give you almost the same result.

bye, Roman
