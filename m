Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbTAFQe6>; Mon, 6 Jan 2003 11:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbTAFQe6>; Mon, 6 Jan 2003 11:34:58 -0500
Received: from smtp.mailix.net ([216.148.213.132]:13488 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id <S267072AbTAFQe5>;
	Mon, 6 Jan 2003 11:34:57 -0500
Date: Mon, 6 Jan 2003 17:43:32 +0100
From: Alex Riesen <fork0@users.sf.net>
To: Doug McNaught <doug@mcnaught.org>
Cc: Dirk Bull <dirkbull102@hotmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: shmat problem
Message-ID: <20030106164332.GA16131@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <20030106162251.GA15900@steel> <m3wuligrqg.fsf@varsoon.wireboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wuligrqg.fsf@varsoon.wireboard.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught, Mon, Jan 06, 2003 17:36:39 +0100:
> > You have to add SHM_REMAP to shmat flags (see definitions of SHM_ flags).
> Hmm, the manpage (on RH7.3 at least) doesn't mention SHM_REMAP.  Nice
> to know about it.

RH7.3 manpage is quiet old, btw.

Linux manpages-1.54 (Dec 30 2002):

   The  (Linux-specific) SHM_REMAP flag may be asserted in shmflg to indi-
   cate that the mapping of the segment should replace any  existing  map-
   ping  in  the  range starting at shmaddr and continuing for the size of
   the segment.  (Normally an EINVAL  error  would  result  if  a  mapping
   already  exists in this address range.)  In this case, shmaddr must not
   be NULL.

-alex
