Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129129AbRBAGGS>; Thu, 1 Feb 2001 01:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129336AbRBAGGM>; Thu, 1 Feb 2001 01:06:12 -0500
Received: from npt12056206.cts.com ([216.120.56.206]:8461 "HELO
	forty.spoke.nols.com") by vger.kernel.org with SMTP
	id <S129129AbRBAGGF>; Thu, 1 Feb 2001 01:06:05 -0500
Date: Wed, 31 Jan 2001 22:06:03 -0800
From: David Rees <dbr@spoke.nols.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre10 -> 2.4.1 klogd at 100% CPU ; 2.4.0 OK
Message-ID: <20010131220603.D1192@spoke.nols.com>
Mail-Followup-To: David Rees <dbr@spoke.nols.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E14O1Qe-00021Z-00@qiwi.ai.mit.edu> <3A7852A9.1060600@AnteFacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A7852A9.1060600@AnteFacto.com>; from Padraig@AnteFacto.com on Wed, Jan 31, 2001 at 06:00:09PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 06:00:09PM +0000, Padraig Brady wrote:
> Chris Hanson wrote:
> 
> >    Date: Wed, 31 Jan 2001 17:48:50 +0000
> >    From: Padraig Brady <Padraig@AnteFacto.com>
> > 
> >    Are you using the 3c59x driver?
> > 
> > Yes.
> 
> Can we sort this out once and for all? There are a few emails
> everyday relating to this bug.
> 
> The following patch posted by "Troels Walsted Hansen" <troels@thule.no>
> on Jan 11th fixes this. The problem is that when 2 consequtive
> NULLs are sent to klogd it goes into a busy loop. Andrew Mortons
> 3c59x driver does this, but also on Jan 11th he replied that he had
> fixed it. I'm using 2.4ac4 with no problems, so I presume some
> of these patches have been lost along the way?
<snip of patch>

And if you are using RedHat, you can also grab the latest sysklogd
from rawhide which includes the patch:
ftp://ftp.redhat.com/rawhide/i386/RedHat/RPMS/sysklogd-1.4-5.i386.rpm

-Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
