Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTBXU1A>; Mon, 24 Feb 2003 15:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTBXU1A>; Mon, 24 Feb 2003 15:27:00 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1796 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267430AbTBXU07>;
	Mon, 24 Feb 2003 15:26:59 -0500
Date: Sun, 23 Feb 2003 23:52:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Prasad <prasad_s@students.iiit.net>
Cc: Livio Baldini Soares <livio@ime.usp.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Remote execution of syscalls (was  Re: Syscall from Kernel Space)
Message-ID: <20030223225257.GB120@elf.ucw.cz>
References: <20030221174414.GA28062@ime.usp.br> <Pine.LNX.4.44.0302212321530.6139-100000@students.iiit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302212321530.6139-100000@students.iiit.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> before anything else, thanx for the response, i was very much discouraged 
> by the fact that i did not get any replies...
> 
> coming to whats happening...  lets see it this way... Theres a process (x)  
> that is migrated to some other node. Now any syscall that the process (X)  
> makes is to be shipped back to the originating node.  Say i have a user
> thread (Y) running and receiving requests for syscall executions.  And now
> if i execute a syscall, the syscall will be executed as of (Y) is 
> executing it, but i want the syscall to run as if (X) is executing it!
> The process (X) still exists on the originating system, but is idle.

And problem with Y telling X (using pipe?) to execute syscall is? Also
take a look at OpenMosix.	
								Pavel				

> > > I am sorry for not being clear... but i think its time to tell you where i 
> > > needed it.  I, as a graduating project am working on a
			  ~~~~~~~~~~~~~~~~~~

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
