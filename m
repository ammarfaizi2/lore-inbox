Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbREREDz>; Fri, 18 May 2001 00:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261417AbREREDo>; Fri, 18 May 2001 00:03:44 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54789 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261268AbREREDe>;
	Fri, 18 May 2001 00:03:34 -0400
Date: Fri, 18 May 2001 01:03:24 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Sasi Peter <sape@iq.rulez.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105180553290.27782-100000@iq.rulez.org>
Message-ID: <Pine.LNX.4.21.0105180102260.5531-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001, Sasi Peter wrote:
> On Thu, 17 May 2001, Rik van Riel wrote:
> 
> > Or are you just comparing with 2.2 and you'd rather
> > have 2.2 performance? ;)
> 
> Actually, yes. Doing fileserving with Samba, and also using the box
> interactively feels better with 2.2, and also the average TCP througput
> (measured by iptraf) seems higher.

This part is probably mostly due to the inode and dentry
cache balancing being completely broken in current 2.4
kernels. Expect a patch soon (I'm running something really
ugly right now here at home, I'll make something cleaner).

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

