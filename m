Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313366AbSDGReC>; Sun, 7 Apr 2002 13:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313401AbSDGReB>; Sun, 7 Apr 2002 13:34:01 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:49681 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S313366AbSDGReA>; Sun, 7 Apr 2002 13:34:00 -0400
Date: Sun, 7 Apr 2002 18:33:43 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Steven N. Hirsch" <shirsch@adelphia.net>, linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020407173343.GA18940@compsoc.man.ac.uk>
In-Reply-To: <Pine.LNX.4.44.0204071240360.15439-100000@atx.fast.net> <E16uGg1-0006Ln-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *16uGY0-000194-00*0kYvd1Afdqg* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 06:42:05PM +0100, Alan Cox wrote:

> > And, unless this is reversed the OpenAFS kernel module won't load (it 
> > needs sys_call_table.):
> 
> Correct. There was agreement a very long time ago that code should not patch
> the syscall table (for one its not safe). AFS probably needs fixing so the
> AFS syscall hook is exported portably and nicely in the syscall code.

Sure, AFS can do that ...

But what about the recent discussion on the removal of sys_call_table ?

(I believe it was along the lines of "it's ugly, prevent it ...", "ah,
but it has real uses, so why can't it stay as deprecated/unadvised ?"
"*no response*").

I'm a bit disappointed this has just gone in without any real discussion
on the usefulness of this for certain circumstances :(

regards
john

-- 
"I never understood what's so hard about picking a unique
 first and last name - and not going beyond the 6 character limit."
 	- Toon Moene
