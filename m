Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275096AbRIYQvE>; Tue, 25 Sep 2001 12:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275093AbRIYQuy>; Tue, 25 Sep 2001 12:50:54 -0400
Received: from borg.org ([208.218.135.231]:14343 "HELO borg.org")
	by vger.kernel.org with SMTP id <S275106AbRIYQun>;
	Tue, 25 Sep 2001 12:50:43 -0400
Date: Tue, 25 Sep 2001 12:51:09 -0400
From: Kent Borg <kentborg@borg.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Something Broken in 2.4.9-ac15
Message-ID: <20010925125109.A27695@borg.org>
In-Reply-To: <1001377785.1430.7.camel@gromit.house> <20010925112012.C27059@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010925112012.C27059@borg.org>; from kentborg@borg.org on Tue, Sep 25, 2001 at 11:20:12AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 11:20:12AM -0400, I, Kent Borg wrote:
> xosview thinks the CPU is pinned at 100% SYS when
> nothing is going on.  I drag a window around and I get plenty of USR
> and even some FREE, but let go and it goes back to 100%.

OK, so the above is nonsense.  I reverted through each of the kernels
I have built of late--and kapm.idled is what is taking up all the
time.  Which I guess is the right thing to do, I had heard about this
once, but then I got confused by it when I suddenly started paying
lots of attention.  It is unfortunate that an idle daemon doesn't get
counted as free, but I think I understand why.  Sorry for the
confusion.

Still, I am convinced the constant report of zero swap usage is wrong
in 2.4.9-ac15.


-kb
