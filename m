Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264852AbRFTHE0>; Wed, 20 Jun 2001 03:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbRFTHEQ>; Wed, 20 Jun 2001 03:04:16 -0400
Received: from apollo.nbase.co.il ([194.90.137.2]:34311 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP
	id <S264852AbRFTHEH>; Wed, 20 Jun 2001 03:04:07 -0400
Message-ID: <3B305A87.E4CAD52@nbase.co.il>
Date: Wed, 20 Jun 2001 10:10:47 +0200
From: eran@nbase.co.il (Eran Man)
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: vlan@Scry.WANfear.com
CC: "David S. Miller" <davem@redhat.com>, Dax Kelson <dkelson@gurulabs.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        "vlan-devel (other)" <vlan-devel@lists.sourceforge.net>,
        Lennert <buytenh@gnu.org>, Gleb Natapov <gleb@nbase.co.il>
Subject: Re: [VLAN] Re: Should VLANs be devices or something else?
In-Reply-To: <3B2FCE0C.67715139@candelatech.com>
			<Pine.LNX.4.33.0106191641150.17061-100000@duely.gurulabs.com> <15151.55017.371775.585016@pizda.ninka.net> <3B2FDD62.EFC6AEB1@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben Greear wrote:
> 
> "David S. Miller" wrote:

> > Conceptually, svr4 streams are a beautiful and elegant
> > mechanism. :-)
> >
> > Technical implementation level concerns need to be considered
> > as well as "does it look nice".
> 
> I found it to be the easiest way to implement things.  It allowed
> me to not have to touch any of layer 3, and I did not have to patch
> any user-space program like ip or ifconfig.
> 
> I'm not even sure if the nay-sayers ever had another idea, they
> just didn't like having lots of interfaces.  Originally, there
> were claims of inefficiency, but it seems that other than things
> like 'ip' and ifconfig, there are no serious performance problems
> I am aware of.

There is the issue with netlink notification of large number of events.
See the mail thread starting from:
http://oss.sgi.com/projects/netdev/mail/netdev/msg01879.html
