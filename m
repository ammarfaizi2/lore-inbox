Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbRHAUVr>; Wed, 1 Aug 2001 16:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268078AbRHAUVh>; Wed, 1 Aug 2001 16:21:37 -0400
Received: from [194.77.109.75] ([194.77.109.75]:43537 "EHLO warp.zuto.de")
	by vger.kernel.org with ESMTP id <S268093AbRHAUV1>;
	Wed, 1 Aug 2001 16:21:27 -0400
From: Rainer Clasen <bj@zuto.de>
Date: Wed, 1 Aug 2001 22:21:34 +0200
To: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
        linux-net@vger.kernel.org
Subject: Re: [OOPS] network related crash with Linux 2.4
Message-ID: <20010801222134.H13386@zuto.de>
Reply-To: bj@zuto.de
Mail-Followup-To: linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@redhat.com>, linux-net@vger.kernel.org
In-Reply-To: <005f01c10e69$28273e60$0200a8c0@loki> <15189.2408.59953.395204@pizda.ninka.net> <20010720091329.B16207@zuto.de> <15191.56739.635100.533146@pizda.ninka.net> <20010720173655.F23559@zuto.de> <87d77ae2x6.fsf@gryffindor.sc> <20010710071924.E15071@zuto.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010710071924.E15071@zuto.de>; from bj@zuto.de on Tue, Jul 10, 2001 at 07:19:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 07:19:24AM +0200, Rainer Clasen wrote:
> Am Mon, Jul 09, 2001 at 01:51:17PM +0200 schrieb Moritz Schulte:
> > I often see my Gateway (Cx486DX4 CPU, 14364K RAM, 124956K Swap)
> > running Linux 2.4.[56] crashing (should I test previous
> > versions?). These crashes seem related to networking, because they
> > happen when trying to access some hosts. Now, the system crashes
> 
> this seems to be similar to my oopsen - 

On Fri, Jul 20, 2001 at 05:36:55PM +0200, Rainer Clasen wrote:
> On Fri, Jul 20, 2001 at 12:28:35AM -0700, David S. Miller wrote:
> > Rainer Clasen writes:
> >  > I am using tulip, dummy, Ben Grear's dot1q VLAN devices and some ISDN
> >  > syncppp and ISDN rawip devices are configured (but not actively used),
> >  > too.
> > 
> > Can you test without dummy and VLAN?  Man, I now have to audit that
> > friggin' code too :-(
> 
> As first step I've removed dummy. Eliminating Vlan is difficult and will take
> me some more time. 

Marc Boucher posted a patch on the netfilter list, that solved my
problems.


Rainer

-- 
KeyID=759975BD fingerprint=887A 4BE3 6AB7 EE3C 4AE0  B0E1 0556 E25A 7599 75BD
