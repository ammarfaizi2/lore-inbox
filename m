Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262988AbSJGLjc>; Mon, 7 Oct 2002 07:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262990AbSJGLjc>; Mon, 7 Oct 2002 07:39:32 -0400
Received: from are.twiddle.net ([64.81.246.98]:33705 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262988AbSJGLjb>;
	Mon, 7 Oct 2002 07:39:31 -0400
Date: Mon, 7 Oct 2002 04:45:06 -0700
From: Richard Henderson <rth@twiddle.net>
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, jakub@redhat.com,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20021007044506.D3910@twiddle.net>
Mail-Followup-To: Andi Kleen <ak@muc.de>,
	"David S. Miller" <davem@redhat.com>, jakub@redhat.com,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20020929152731.GA10631@averell> <20020929160113.K5659@devserv.devel.redhat.com> <20021007030541.A3910@twiddle.net> <20021007.032900.51704978.davem@redhat.com> <20021007105622.GA24530@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021007105622.GA24530@averell>; from ak@muc.de on Mon, Oct 07, 2002 at 12:56:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 12:56:22PM +0200, Andi Kleen wrote:
> I retested it on gcc 3.2 and it unfortunately doesn't make any difference
> (resulting kernel is byte-for-byte identical). So it looks like with
> current gcc it isn't worth the effort.

*shrug* It's still good documentation of intent.  And one of
these days we might get around to writing some aliasing code
that doesn't suck quite so much.  ;-)


r~
