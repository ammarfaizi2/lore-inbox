Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269789AbRHDE0P>; Sat, 4 Aug 2001 00:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269790AbRHDE0F>; Sat, 4 Aug 2001 00:26:05 -0400
Received: from marine.sonic.net ([208.201.224.37]:62726 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S269789AbRHDE0B>;
	Sat, 4 Aug 2001 00:26:01 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Fri, 3 Aug 2001 21:26:05 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010803212605.K437@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5gr8usmqkg.fsf@egghead.curl.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 11:50:23PM -0400, Patrick J. LoPresti wrote:
> Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:
> 
> > On Fri, 03 Aug 2001, Patrick J. LoPresti wrote:
> > 
> > > To fill in more of the table, Qmail does:
> > > 
> > >   fd = open(tmp)
> > >   write(fd)
> > >   fsync(fd)
> > >   link(tmp,final)
> > >   close(fd)
> > 
> > http://cr.yp.to/qmail/faq/reliability.html
> 
> ...which is consistent.  Qmail is assuming that the link() is
> synchronous, as it was back in the "Good Old Days" of stock FFS.

Which, from my reading of the archives, even BSD folk say is a "Bad 
Thing(tm)."

mrc

-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
