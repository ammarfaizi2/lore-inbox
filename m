Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132985AbRAYRwL>; Thu, 25 Jan 2001 12:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132699AbRAYRwB>; Thu, 25 Jan 2001 12:52:01 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:16460 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S132027AbRAYRvm>;
	Thu, 25 Jan 2001 12:51:42 -0500
Message-ID: <3A7067A4.7080206@valinux.com>
Date: Thu, 25 Jan 2001 10:51:32 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: x86 PAT errata
In-Reply-To: <200101251745.SAA07063@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

> Before people get too exited about the x86 Page Attribute Table ...
> Does Linux use mode B (CR4.PSE=1) or mode C (CR4.PAE=1) paging?
> If so, known P6 errata must be taken into account.
> In particular, Pentium III errata E27 and Pentium II errata A56
> imply that only the low four PAT entries are working for 4KB
> pages, if CR4.PSE or CR4.PAE is enabled.
> 
> /Mikael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

Yes it does use PSE/PAE paging.  Could you point me to these errata 
documents?  According to the documentation I've seen it says that only 
the low four PAT entries work for 4MB pages.  I've never seen 
documentation that says the same is true for 4k pages.

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
