Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbSJPVlH>; Wed, 16 Oct 2002 17:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbSJPVjs>; Wed, 16 Oct 2002 17:39:48 -0400
Received: from mark.mielke.cc ([216.209.85.42]:37644 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261437AbSJPVjO>;
	Wed, 16 Oct 2002 17:39:14 -0400
Date: Wed, 16 Oct 2002 17:44:55 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Samuel Flory <sflory@rackable.com>
Cc: mcuss@cdlsystems.com, jamesclv@us.ibm.com, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
Message-ID: <20021016214455.GA9624@mark.mielke.cc>
References: <Pine.LNX.3.95.1021016135105.150A-100000@chaos.analogic.com> <200210161228.58897.jamesclv@us.ibm.com> <0d3901c2754c$7bf17060$2c0e10ac@frinkiac7> <3DADD064.8010707@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DADD064.8010707@rackable.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 01:47:32PM -0700, Samuel Flory wrote:
>   Try shutting off hyperthreading in the bios.  Keep in mind 
> hyperthreading is net loss if you are running a single nonthreaded app. 
> Also you might want to check if there aren't io speed issues.  

Is this true? It seems to me that the 'on-demand execution units' would
simply be devoted to the one task, resulting in zero loss.

I see hyperthreading becoming a problem if two threads are scheduled to
execute at the same time before the operating system, and if they each
need access to the same execution units at the same time.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

