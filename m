Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285703AbSALLLo>; Sat, 12 Jan 2002 06:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285704AbSALLLe>; Sat, 12 Jan 2002 06:11:34 -0500
Received: from theirongiant.weebeastie.net ([203.62.148.50]:14723 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S285703AbSALLLZ>; Sat, 12 Jan 2002 06:11:25 -0500
Date: Sat, 12 Jan 2002 22:04:38 +1100
From: CaT <cat@zip.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
Subject: Re: netfilter oops (Was: Re: Linux 2.4.18-pre2)
Message-ID: <20020112110438.GB7198@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bounced from lk (due to a malformed address)... apologies for the
resend if you get it twice...  Just wanted to remove a bit of chaos from
the thread. ;)

On Tue, Jan 08, 2002 at 04:12:30PM +1100, Rusty Russell wrote:
> > With 18-pre1, 17-rc2 and 17-preX (can't remember now. It's been a week
> > or so :/) I can get the kernel to consistantly crash after a few minutes
> > by compiling it with ipchains compatability and using masqueraded net
> > connections.
> 
> Hi,

Hey.

I haven't forgotten about this little bug. :))

> 	There are three changes which could effect you here.  I can't see
> anything wrong with any of them, but if you could try reverting them one
> at a time, and tell me which causes the problem, that'd narrow it down:

Just did a test and it's not masquerading that's causing it. I'll need
to convert my filesystems to ext3 first because the crashes are not
going to be healthy for this box (or me... 45gig HD involved on a
pentium-200) and I'll experiment some more. It may be redirection
that's doing it.

Once I narrow down what is actually causing it I'll back out the patches
you sent, one by one, until it stops crashing.

-- 
SOCCER PLAYER IN GENITAL-BITING SCANDAL  ---  "It was something between
friends that I thought would have no importance until this morning when
I got up and saw all  the commotion in the news,"  Gallardo told a news
conference. "It stunned me."
Reyes told Marca that he had "felt a slight pinch."
