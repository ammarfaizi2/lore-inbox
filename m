Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131559AbQKYSqA>; Sat, 25 Nov 2000 13:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131430AbQKYSpu>; Sat, 25 Nov 2000 13:45:50 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:57102 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S129648AbQKYSpl>; Sat, 25 Nov 2000 13:45:41 -0500
Date: Sat, 25 Nov 2000 12:12:24 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setting up pppd dial-in on linux
Message-ID: <20001125121224.B29510@vger.timpanogas.org>
In-Reply-To: <20001125003600.A28207@vger.timpanogas.org> <3A1FCCA8.608.1E5DAB@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A1FCCA8.608.1E5DAB@localhost>; from pmanuel@myrealbox.com on Sat, Nov 25, 2000 at 02:28:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 02:28:56PM +0100, Pedro M. Rodrigues wrote:
> 
>    You are not alone. And the problem gets even worse when you 
> have to deal with ISDN devices. In my company´s data room we 
> have all Linux servers running 365 days a year (minus upgrade 
> time) and in one corner a lonely Windows NT Server 3.0 with 5 
> Client Access Licenses working as a RAS server for 2 Diva Server 
> BRI cards (4 analog/digital channels) plus one analog modem. 
> Time to set it up? Half an hour counting NT installation. Time i lost 
> investigating and trying different configurations, dealing with 
> contradictory documentation, chat scripts, different ipppd versions, 
> and authentication failures? 2 days. At Ieast i cant complain about 
> pppd oops, as you do, the pppd in RH6.2 seemed solid. The 
> document of reference that seemed more interesting to me at the 
> time was http://www.swcp.com/~jgentry/pers.html  , have a look 
> please.

Thanks.  We need to get the Linux stuff to the same point.  From 
our analysis, it's the only weak feature left -- Linux either 
matches or surpasses NT in every other area now except this one.

Jeff

> 
> 
> Regards,
> Pedro
> 
> On 25 Nov 2000, at 0:36, Jeff V. Merkey wrote:
> 
> > 
> > 
> > Anyone out there a whiz at setting up a pppd dialin server?  I am 
> > trying to put together an RPM for pppd dialin configurations
> > that will support default Windows NT and Linux dial in clients
> > without requiring the poor user to learn bash scripting, chat 
> > scripting, mgetty and inittab configuration, etc.  The steps
> > in setting this up are about as easy as going on a U.N. relief
> > mission to equatorial Africa, and most customers who are 
> > "mere mortals" would give up about an hour into it.
> > 
> > I am seeing massive problems with pppd dial-in and IP/IPX 
> > routing with problems that range from constant Oops, to 
> > the bug infested pppd daemon failing valid MD5 chap 
> > authentication.  The HOW-TO's and man pages provide 
> > wonderful commentary on all the things about pppd 
> > that don't work, but it's not too helpful on getting
> > it to work reliably.  An NT dial-in server takes about
> > 5 minutes to configure on W2K.  Linux takes about 2 days, and 
> > won't stay up reliably.  
> > 
> > Who out there is an expert on Linux pppd that would like
> > to help put together some easy configs for standard 
> > dial-in scenarios?
> > 
> > Thanks
> > 
> > Jeff
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> > 
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
