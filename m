Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbRERUw7>; Fri, 18 May 2001 16:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbRERUwu>; Fri, 18 May 2001 16:52:50 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:6154 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S261553AbRERUwn>; Fri, 18 May 2001 16:52:43 -0400
Date: Fri, 18 May 2001 22:52:30 +0200
From: Kurt Roeckx <Q@ping.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Evans <chris@scary.beasts.org>, linux-kernel@vger.kernel.org,
        davem@redhat.com
Subject: Re: Kernel bug with UNIX sockets not detecting other end gone?
Message-ID: <20010518225230.A19506@ping.be>
In-Reply-To: <20010518192422.B18162@ping.be> <E150qSZ-0007cw-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <E150qSZ-0007cw-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2001 at 09:02:51PM +0100, Alan Cox wrote:
> > What I'm seeing however in an other program is that select says I
> > can read from the socket, and that read returns 0, with errno set
> > to EGAIN.  I call select() again, with returns and says I can read
> 
> No no no. If the read does not return -1 it does not change errno. EOF isnt
> an error.

Of course, how stupid of me.


Kurt

