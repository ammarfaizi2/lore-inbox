Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143908AbRA1Ta0>; Sun, 28 Jan 2001 14:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143909AbRA1TaQ>; Sun, 28 Jan 2001 14:30:16 -0500
Received: from [63.95.87.168] ([63.95.87.168]:22540 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S143908AbRA1TaJ>;
	Sun, 28 Jan 2001 14:30:09 -0500
Date: Sun, 28 Jan 2001 14:30:07 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        James Sutherland <jas88@cam.ac.uk>,
        David Schwartz <davids@webmaster.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: hotmail not dealing with ECN
Message-ID: <20010128143007.A13195@xi.linuxpower.cx>
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKCECMNFAA.davids@webmaster.com> <Pine.SOL.4.21.0101272308030.701-100000@green.csi.cam.ac.uk> <20010127191159.B7467@xi.linuxpower.cx> <20010128021025.D800@uni-mainz.de> <20010127233543.D7467@xi.linuxpower.cx> <20010128135753.A2766@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010128135753.A2766@uni-mainz.de>; from dominik.kubla@uni-mainz.de on Sun, Jan 28, 2001 at 01:57:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 01:57:53PM +0100, Dominik Kubla wrote:
> On Sat, Jan 27, 2001 at 11:35:43PM -0500, Gregory Maxwell wrote:
> ...
> > An attack against an Xray system is much more likely to come from inside the
> > companies network.
> ...
> 
> We are not talking about attacks here, we are talking about undefined
> behaviour when (perhaps poorly designed) systems encounter network
> packages that use new or experimental features: I have seen MRI scanners
> panic when they received SNMP queries and SNMP has been around for ages!

The discussion was over centralized firewalls. Putting a firewall right on
top of a system is the same as putting it on the system. Putting a firewall
on your Internet connection would be insufficient to protect such a system.

It's not a question of how long something has been around. You should be
able to send line noise into the Ethernet port of any IP host and not have
it behave adversly. Anything less and you *WILL* have problems.

I would hope that you have enough sense to NOT connect any such broken
systems in any way to a public network. 

Yet, another point against firewalls: Apparently they encourage computer
professionals to behave criminally negligent by making it acceptable to
implement broken life critical services. 

Firewalling your hospital's Internet connection to prevent your tomographic
equipment from producing bad results due to a port scan rather then
correctly repairing the system is computer equivalent of placing the fuel tank
on the outside of the frame on a car (Pinto): Since it's protected by it's
own wall and the outer body, casual impacts won't make the defect noticeable.

Less people would have died in the pinto if the fuel tank was made of
sugar-glass and placed prominently on the hood. Not because it's safer that
way, but because out of both of the defective configurations the
tank-on-the-hood is obviously broken and would get fixed or not used.

Firewalls only actually improve security when there is only a single domain
of trust behind them. Often we have multiple domains of trust even within a
single system. Internet filtering firewalls provide nothing more then a
false sense of security, and some opportunistic script kiddie protection.

The continued profiteering by security 'experts' and acceptance of
magic-boxes by systems administrators ensures that better solutions are not
implemented.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
