Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130282AbRALJpV>; Fri, 12 Jan 2001 04:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbRALJpL>; Fri, 12 Jan 2001 04:45:11 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:23029 "EHLO
	lappi.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S130282AbRALJoz>; Fri, 12 Jan 2001 04:44:55 -0500
Date: Fri, 12 Jan 2001 03:56:20 -0200
From: Ralf Baechle <ralf@conectiva.com.br>
To: David Weinehall <tao@acc.umu.se>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Arcangeli <andrea@suse.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Zlatko Calusic <zlatko@iskon.hr>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010112035620.B1254@bacchus.dhis.org>
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010111005657.B2243@khan.acc.umu.se>; from tao@acc.umu.se on Thu, Jan 11, 2001 at 12:56:57AM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 12:56:57AM +0100, David Weinehall wrote:

> > The MMU on these systems is a CAM, and the mmu table is thus backwards to
> > convention. (It also means you can notionally map two physical addresses to
> > one virtual but thats undefined in the implementation ;))
> 
> Are there any other (not yet supported) platforms with similar (or other
> unrelated, but hard to support because of the current architecture of
> the kernel) problems?
> 
> (No, I have no secret trumps up my sleeve, I'm just curious.)

Having a reverse mappings is the least sucky way to handle virtual aliases
of certain types of MIPS caches.

  Ralf

--
"Embrace, Enhance, Eliminate" - it worked for the pope, it'll work for Bill.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
