Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278713AbRJTBly>; Fri, 19 Oct 2001 21:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278714AbRJTBlo>; Fri, 19 Oct 2001 21:41:44 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:64017 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S278713AbRJTBlh>; Fri, 19 Oct 2001 21:41:37 -0400
Date: Sat, 20 Oct 2001 11:41:59 +1000
From: john slee <indigoid@higherplane.net>
To: Tim Jansen <tim@tjansen.de>, Patrick Mochel <mochel@osdl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011020114159.H5511@higherplane.net>
In-Reply-To: <Pine.LNX.4.33.0110191108590.17647-100000@osdlab.pdx.osdl.net> <15uerh-0NbBEeC@fmrl04.sul.t-online.com> <20011019122101.G2467@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011019122101.G2467@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 12:21:01PM -0700, Mike Fedyk wrote:
> When is /etc/fstab going to support this?

it does; at least on my debian system:

# e2label /dev/hda1

# e2label /dev/hda1 foo 
# e2label /dev/hda1
foo
# mount LABEL=foo /mnt
# 

you can use the same LABEL=foo syntax in /etc/fstab...
according to my fstab(5) manpage this also works with xfs, although i've
not tried it.

surely i am not deluded and this is a not-debian-specific feature?
having used nothing but debian for some years now i really can't be
sure...

j.

--
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
