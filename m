Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262616AbRFQTLR>; Sun, 17 Jun 2001 15:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRFQTLJ>; Sun, 17 Jun 2001 15:11:09 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:384 "HELO spiral.extreme.ro")
	by vger.kernel.org with SMTP id <S262622AbRFQTK7>;
	Sun, 17 Jun 2001 15:10:59 -0400
Date: Sun, 17 Jun 2001 22:12:39 +0300
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 VM & swap question
Message-ID: <20010617221239.B1027@spiral.extreme.ro>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010617104836.B11642@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010617104836.B11642@opus.bloom.county>; from trini@kernel.crashing.org on Sun, Jun 17, 2001 at 10:48:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2001 at 10:48:36AM -0700, Tom Rini wrote:
> 'lo all.  I've got a question about swap and RAM requirements in 2.4.  Now,
> when 2.4.0 was kicked out, the fact that you need swap=2xRAM was mentioned.
> But what I'm wondering is what exactly are the limits on this.  Right now
> I've got an x86 box w/ 128ram and currently 256swap.  When I had 128, I'd get
> low on ram/swap after some time in X, and doing this seems to 'fix' it, in
> 2.4.4.  However, I've also got 2 PPC boxes, both with 256:256 in 2.4.  One
> of which never has X up, but lots of other activity, and swap usage seems
> to be about the same as 2.2.x (right now 'free' says i'm ~40MB into swap,
> 18day+ uptime).  The other box is a laptop and has X up when it's awake and
> that too doesn't seem to have any problem.  So what exactly is the real
> minium swap ammount?

I doubt there is a limit. I think 'it depends on what you're planning
to do' is the correct answer. For a blank router, 32mb ram/64 swap can
be enough, for a web/database server, you need more, etc.

