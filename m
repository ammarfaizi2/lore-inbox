Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272636AbRJIGnp>; Tue, 9 Oct 2001 02:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272882AbRJIGnf>; Tue, 9 Oct 2001 02:43:35 -0400
Received: from dot.cygnus.com ([205.180.230.224]:773 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S272636AbRJIGnU>;
	Tue, 9 Oct 2001 02:43:20 -0400
Date: Mon, 8 Oct 2001 23:43:35 -0700
From: Richard Henderson <rth@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Paul.McKenney@us.ibm.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011008234335.A7127@redhat.com>
In-Reply-To: <OF2F33BD66.440BE6A1-ON88256AE0.001DFF26@boulder.ibm.com> <20011008.225610.94885115.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011008.225610.94885115.davem@redhat.com>; from davem@redhat.com on Mon, Oct 08, 2001 at 10:56:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 10:56:10PM -0700, David S. Miller wrote:
> I somehow doubt that you need an IPI to implement the equivalent of
> "membar #StoreStore" on Alpha.  Richard?

Lol.  Of course not.  Is someone under the impression that AXP
designers were smoking crack?

"wmb" == "membar #StoreStore".
"mb"  == "membar #Sync".

See the nice mb/rmb/wmb macros in <asm/system.h>.


r~
