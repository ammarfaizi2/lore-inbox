Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBNCbj>; Tue, 13 Feb 2001 21:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbRBNCb3>; Tue, 13 Feb 2001 21:31:29 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:14215 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129159AbRBNCbR>; Tue, 13 Feb 2001 21:31:17 -0500
Date: Tue, 13 Feb 2001 18:30:51 -0800
From: Richard Henderson <rth@twiddle.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Carlos Carvalho <carlos@fisica.ufpr.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre10 doesn't compile on alphas (sunrpc)
Message-ID: <20010213183051.A17453@twiddle.net>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Carlos Carvalho <carlos@fisica.ufpr.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <14984.24279.786295.783864@hoggar.fisica.ufpr.br> <E14SRCN-0008Gj-00@the-village.bc.nu> <14984.25773.89918.915295@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14984.25773.89918.915295@pizda.ninka.net>; from davem@redhat.com on Mon, Feb 12, 2001 at 02:33:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 02:33:17PM -0800, David S. Miller wrote:
> You have to add a few bits to arch/alpha/kernel/traps.c
> I could be wrong though...

Only to make the oops look pretty.  Something like

        die_if_kernel((type == 1 ? "Kernel Bug" : "Instruction fault"),
                      &regs, type, 0);

Don't have a 2.2 tree handy to look at the moment...


r~
