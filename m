Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318034AbSHHWdj>; Thu, 8 Aug 2002 18:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318042AbSHHWdj>; Thu, 8 Aug 2002 18:33:39 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:40719 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318034AbSHHWdi>; Thu, 8 Aug 2002 18:33:38 -0400
Date: Thu, 8 Aug 2002 19:37:08 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hubertus Franke <frankeh@us.ibm.com>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@zip.com.au>, <andrea@suse.de>, <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Paul Larson <plars@austin.ibm.com>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
In-Reply-To: <Pine.LNX.4.44.0208081500550.9114-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0208081936170.2589-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Linus Torvalds wrote:
> On Thu, 8 Aug 2002, Hubertus Franke wrote:
> >
> > That is true. All was done under the 16-bit assumption
> > My hunch is that the current algorithm might actually work quite well
> > for a sparsely populated pid-space (32-bits).
>
> I agree.
>
> So let's just try Andries approach, suggested patch as follows..

Hmmm, I wonder how badly the system will behave when
we need to reset last_pid and next_safe with 30000
pids in use ...

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

