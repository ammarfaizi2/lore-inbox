Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288677AbSADPqh>; Fri, 4 Jan 2002 10:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288675AbSADPq1>; Fri, 4 Jan 2002 10:46:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34064 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288674AbSADPqL>;
	Fri, 4 Jan 2002 10:46:11 -0500
Message-ID: <3C35CE40.836D3552@mandrakesoft.com>
Date: Fri, 04 Jan 2002 10:46:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Erik Andersen <andersen@codepoet.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LSB1.1: /proc/cpuinfo
In-Reply-To: <20020103190219.B27938@thyrsus.com> <Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu> <20020103195207.A31252@thyrsus.com> <20020104081802.GC5587@codepoet.org> <20020104071940.A10172@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> I'm not very worried about this.  On modern machines int == long

I have been attempting to hammer this incorrect assumption out of
people's brains for years, and have submitted many patches to Linus [1]
over time, removing such crud from the kernel.

Such an assumption is blatantly non-portable, rendering your code
fragile.

	Jeff, longtime alpha owner



[1] and other userland maintainers

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
