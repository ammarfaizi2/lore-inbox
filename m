Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136787AbRA1EgB>; Sat, 27 Jan 2001 23:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136788AbRA1Efw>; Sat, 27 Jan 2001 23:35:52 -0500
Received: from [63.95.87.168] ([63.95.87.168]:64008 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S136787AbRA1Efo>;
	Sat, 27 Jan 2001 23:35:44 -0500
Date: Sat, 27 Jan 2001 23:35:43 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        James Sutherland <jas88@cam.ac.uk>,
        David Schwartz <davids@webmaster.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: [OT] Re: hotmail not dealing with ECN
Message-ID: <20010127233543.D7467@xi.linuxpower.cx>
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKCECMNFAA.davids@webmaster.com> <Pine.SOL.4.21.0101272308030.701-100000@green.csi.cam.ac.uk> <20010127191159.B7467@xi.linuxpower.cx> <20010128021025.D800@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010128021025.D800@uni-mainz.de>; from dominik.kubla@uni-mainz.de on Sun, Jan 28, 2001 at 02:10:25AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 02:10:25AM +0100, Dominik Kubla wrote:
> On Sat, Jan 27, 2001 at 07:11:59PM -0500, Gregory Maxwell wrote:
> > It's this kind of ignorance that makes the internet a less secure and stable
> > place.
> 
> You have obviously absolutely no idea what you are talking about. Period.

Your following comments show exactly who is has no idea of what he is
talking about. Period.
 
> > The network should not be a stateful device. If you need stateful
> > firewalling the only place it should be implimented is on the end node. If
> > management of that is a problem, then make an interface solve that problem
> > insted of breaking the damn network.
> 
> So how do you propose to secure devices like MRT's or X-Ray scanners or
> life-support in a hospital? Nowadays this equipment  is hooked to the
> internal network of the hospital and protected by really paranoid
> firewalls. Do you really want unneeded software on those devices?

Oh yes! This provides you with virtually zero extra security.
Now someone in the next room, perhaps the lobby, is free to attack the
system... Which probably has very little extra security and trusts the
network (after all, it's firewall protected).

An attack against an Xray system is much more likely to come from inside the
companies network.

The only way to have firewall protection against even a simple majority of
attacks is to implement a firewall per system. That would be expensive, and
wasteful, so it makes a lot more sense to implement a firewall IN every
system. Such a thing can be done at zero expense with practically no
performance loss and not break the end-to-end model of the Internet.

But such a simple solution would totally invalidate the use for most
security 'experts' and their products. 

Firewalling is commodity. Cope. It's much more useful to push it to the
end-node where it belongs. But look where security companies make their
money.... The most common business affecting security violations are
internal. Yes, many security companies are making most of their money
selling expensive and pointless network profalatics. Why? For firewalling to
be affordable on every system, it has to be free. Thats not profitable for
security companies which is why you never hear it suggested, even though it
actually can defend against the most common threats.

The very fact that you bring up medical systems and suggest that I purposed
leaving them unsecured shows that your only avenue for discussion was
hysteria.
 
> Or what about the computer systems in nuclear powerplants? In air defense
> systems?  Power grids? Water supply?
> Oh come on! Just reread some of the newspapers back from Dec 31 1999!

Mythology and hysteria. The same things that promotes the propagation of
network degrading central firewalls.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
