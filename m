Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262782AbSJWCht>; Tue, 22 Oct 2002 22:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSJWCht>; Tue, 22 Oct 2002 22:37:49 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:35853 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262782AbSJWChr>; Tue, 22 Oct 2002 22:37:47 -0400
Date: Tue, 22 Oct 2002 22:43:57 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status
Message-ID: <20021023024357.GL536@phunnypharm.org>
References: <Pine.LNX.4.44.0210222038380.8594-100000@dad.molina> <20021023022852.GK536@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021023022852.GK536@phunnypharm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 10:28:52PM -0400, Ben Collins wrote:
> > --------------------------------------------------------------------------
> >    open                   21 Oct 2002 oops in ieee1394
> >   74. http://marc.theaimsgroup.com/?l=linux-kernel&m=103519819428268&w=2
> > 
> > --------------------------------------------------------------------------
> 
> Oh this is a real ass biter.
> 
> I have a workqueue that I setup once. Same data, same function, it never
> changes. Every so often I call schedule_work() for the task.

Wait. I was looking at the wrong queue. This was a queue that I had list
linked myself, and then went through one at a time and attempted to
schedule it.

Already gone in my current code, so this will be closed the next time I
sync to Linus (which should be by the weekend).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
