Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132293AbRAZP23>; Fri, 26 Jan 2001 10:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbRAZP2T>; Fri, 26 Jan 2001 10:28:19 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:57871 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S132293AbRAZP2H>; Fri, 26 Jan 2001 10:28:07 -0500
Date: Fri, 26 Jan 2001 16:27:07 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        Lars Marowsky-Bree <lmb@suse.de>, James Sutherland <jas88@cam.ac.uk>,
        "David S. Miller" <davem@redhat.com>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126162707.E7096@pcep-jamie.cern.ch>
In-Reply-To: <20010126124426.O2360@marowsky-bree.de> <Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk> <20010126154447.L3849@marowsky-bree.de> <20010126160342.B7096@pcep-jamie.cern.ch> <20010126161616.A21435@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010126161616.A21435@uni-mainz.de>; from dominik.kubla@uni-mainz.de on Fri, Jan 26, 2001 at 04:16:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla wrote:
> On Fri, Jan 26, 2001 at 04:03:42PM +0100, Jamie Lokier wrote:
> ...
> > Applications tend not to.  Do we care about those that do?
> 
> Apache? ... Sendmail? ... Samba? ... The class? ... Bueller? Bueller? ...

Yeah, Apache and Samba establish _outgoing_ connections with fixed
source ports.... Not!

Or do these broken firewalls let ECN flags out but not in?

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
