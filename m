Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129426AbQLBTaz>; Sat, 2 Dec 2000 14:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbQLBTaq>; Sat, 2 Dec 2000 14:30:46 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:11780
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129426AbQLBTa3>; Sat, 2 Dec 2000 14:30:29 -0500
Date: Sun, 3 Dec 2000 07:59:58 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Donald Becker <becker@scyld.com>
Cc: Francois Romieu <romieu@cogenit.fr>, Russell King <rmk@arm.linux.org.uk>,
        Ivan Passos <lists@cyclades.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
Message-ID: <20001203075958.A1121@metastasis.f00f.org>
In-Reply-To: <20001201140042.A8572@se1.cogenit.fr> <Pine.LNX.4.10.10012021041460.16980-100000@vaio.greennet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012021041460.16980-100000@vaio.greennet>; from becker@scyld.com on Sat, Dec 02, 2000 at 11:09:35AM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2000 at 11:09:35AM -0500, Donald Becker wrote:

    On Fri, 1 Dec 2000, Francois Romieu wrote:
    
    > Russell King <rmk@arm.linux.org.uk> écrit :
    > [...]
    > > We already have a standard interface for this, but many drivers do not
    > > support it.  Its called "ifconfig eth0 media xxx":
    
    Uhmmm, it's not a standard if "many drivers do not support it".
    
    It is very easy to hack up code to handle one or two drivers.
    But you shouldn't claim the problem is fixed until the approach is tested
    with all of the driver.
    
    Hey, I'll make it easy.  Find an approach that fully handles only the Tulip
    and 3c59x drivers, and that is consistent.

Actually, I starteed work on adding this to the 3c59x code last
night; I am now a little dispondent though as it wasn't as simple as
I first thought it might be.

I am now wondering whether it make sense to break 3c59x into smaller
peices which hander fewer cards each; there soom to be many things
the driver knows about which probably don't relate to my needs.



 --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
