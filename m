Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129539AbQLALDU>; Fri, 1 Dec 2000 06:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129639AbQLALDL>; Fri, 1 Dec 2000 06:03:11 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:9740
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129539AbQLALC6>; Fri, 1 Dec 2000 06:02:58 -0500
Date: Fri, 1 Dec 2000 23:32:27 +1300
From: Chris Wedgwood <cw@f00f.org>
To: romieu@ensta.fr
Cc: Ivan Passos <lists@cyclades.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
Message-ID: <20001201233227.A9457@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.10.10011301103320.4692-100000@main.cyclades.com> <20001201100124.A4986@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001201100124.A4986@se1.cogenit.fr>; from romieu@cogenit.fr on Fri, Dec 01, 2000 at 10:01:24AM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 10:01:24AM +0100, Francois romieu wrote:

    > Questions:
    > - Is there any existing _standard_ interface to do that??
    
    No.

[...]

    > I'm interested in implementing this, but I don't want to reinvent the
    > wheel (if such wheel exists ...).
    
    Ditto.


Actually; Ethernet badly needs something like this too. I would kill
to be able to do something like:

	ifconfig eth0 speed 100 duplex full

o across different networks cards -- I've been thinking about it of
late as I had to battle with this earlier this week; depending on
what network card you use, you need different magic incarnations to
do the above.

A standard interface is really needed; unless anyone objects I may
look at drafting something up -- but it will require some input if it
is not to look completely Ethernet centric.



  --cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
