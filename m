Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318274AbSG3ODc>; Tue, 30 Jul 2002 10:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318278AbSG3ODc>; Tue, 30 Jul 2002 10:03:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:31760 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318274AbSG3ODb>; Tue, 30 Jul 2002 10:03:31 -0400
Date: Tue, 30 Jul 2002 11:06:37 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
       <akpm@zip.com.au>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
In-Reply-To: <p73ptx5s52d.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44L.0207301105520.8815-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jul 2002, Andi Kleen wrote:
> Andrea Arcangeli <andrea@suse.de> writes:
>
> > > Then again, Andi says that sizeof(struct page) is a problem for
> > > x86-64.
> >
> > not true.
>
> x86-64 has slightly below 100 bytes struct page

We really need to look at replacing the page pointers with
page frame numbers and packing the 32-bit variables together
to save some memory on 64-bit architectures.

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

