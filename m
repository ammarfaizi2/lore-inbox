Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSCOLDo>; Fri, 15 Mar 2002 06:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCOLCu>; Fri, 15 Mar 2002 06:02:50 -0500
Received: from mark.mielke.cc ([216.209.85.42]:36361 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S290277AbSCOLBS>;
	Fri, 15 Mar 2002 06:01:18 -0500
Date: Fri, 15 Mar 2002 05:56:59 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UNIX bench better on 2.2 than 2.4?
Message-ID: <20020315055659.A5836@mark.mielke.cc>
In-Reply-To: <3C91A822.7030304@linkvest.com> <20020315053211.A5619@mark.mielke.cc> <3C91D0A3.4050500@linkvest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C91D0A3.4050500@linkvest.com>; from jean-eric.cuendet@linkvest.com on Fri, Mar 15, 2002 at 11:44:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 11:44:51AM +0100, Jean-Eric Cuendet wrote:
> Yes, you are right for this one.
> But what impressed me is between Host2/Host3. One is a dual-866 with 
> 2.4.16 and the other is mono-800 with 2.2.19. And the host3 with 2.2.19 
> is ~7% better than Host2 (Not counting that Host3 has ~8% more CPU 
> clock, which should have be ~15% better for Host2 vs Host3...)

There is no guarantee that UNIX bench is SMP-friendly, or even
designed to test an SMP machine. Single programs that make good use of
an SMP machine usually have to be designed very differently than a
traditional program designed for a single processor.

It is probably just luck that the numbers jump around.

Just because Unix bench performs better or worse, or not as better, on
an SMP machine, as a non-SMP machine, does not mean that the numbers
accurately effect the capabilities of a real-life application. Unless
specifically designed for the environment, it is even possible that the
numbers would not even come close.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

