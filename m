Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293635AbSCERf0>; Tue, 5 Mar 2002 12:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293637AbSCERfP>; Tue, 5 Mar 2002 12:35:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20492 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293635AbSCERfE>;
	Tue, 5 Mar 2002 12:35:04 -0500
Message-ID: <3C8501D8.A20D4A09@mandrakesoft.com>
Date: Tue, 05 Mar 2002 12:35:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Tulip bug?
In-Reply-To: <200203060425.g264PaO00901@dirty-bastard.pthbb.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jerrad Pierce wrote:
> 
> Well I managed to switch the console to the 8x9 font which gave 42 lines of
> spew... No mention of tulip this time, at least not in what was visible.
> Also none of these ever get logged to messages so ksymoops wouldn't help?
> Most of it is Call Trace and Stack, which I am guessing is useless without
> knowing the exact state of the machine before hand (I do have Call Trace and
> Stack available if useful)?
> 
> Other than that I got:
> 
> reference at virtual address 00000070 printing eip: c0120095
> *pde=00000000
> Oops: 0
> CPI=0
> EIP: 0010:[<c0120095>] Not tainted
> ...
> 
> AND
> 
> <1> Unable to hande kernel NULL pointer dereference at virtual address
> 00000000 printing eip: c010ee96
> *pde=00000000
> Oops=0000
> CPU=0
> EIP: 0010:[<c010ee96>] Not tainted
> ...

You need to run this stuff through "ksymoops"...  See REPORTING-BUGS...

-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
