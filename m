Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRANLdj>; Sun, 14 Jan 2001 06:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRANLda>; Sun, 14 Jan 2001 06:33:30 -0500
Received: from Cantor.suse.de ([194.112.123.193]:29961 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129413AbRANLdM>;
	Sun, 14 Jan 2001 06:33:12 -0500
Date: Sun, 14 Jan 2001 12:33:10 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Igmar Palsenberg <i.palsenberg@jdimedia.nl>,
        Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
Message-ID: <20010114123310.A23011@gruyere.muc.suse.de>
In-Reply-To: <14945.26991.35849.95234@pizda.ninka.net> <Pine.LNX.4.30.0101141013080.16469-100000@jdi.jdimedia.nl> <14945.28354.209720.579437@pizda.ninka.net> <20010114115215.A22550@gruyere.muc.suse.de> <14945.34208.281500.226085@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14945.34208.281500.226085@pizda.ninka.net>; from davem@redhat.com on Sun, Jan 14, 2001 at 02:55:28AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 02:55:28AM -0800, David S. Miller wrote:
> 
> Andi Kleen writes:
>  > In my opinion (rt)netlink would benefit a lot from introducing 5-10
>  > new errnos and possibly a new socket option to get a string/number
>  > with the exact error.
> 
> Introducing 5-10 new errnos just for rtnetlink is a big waste when we
> already have socket extended errors which are perfect for this
> purpose.

Just makes the interface rather complicated for the user, but ok. 

How would you pass the extended errors? As strings or as to be defined 
new numbers? I would prefer strings, because the number namespace could
turn out to be as nasty to maintain as the current sysctl one. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
