Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269941AbRHELLy>; Sun, 5 Aug 2001 07:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269943AbRHELLo>; Sun, 5 Aug 2001 07:11:44 -0400
Received: from pD9504018.dip.t-dialin.net ([217.80.64.24]:52718 "HELO
	ozean.schottelius.org") by vger.kernel.org with SMTP
	id <S269941AbRHELLb>; Sun, 5 Aug 2001 07:11:31 -0400
Message-ID: <3B6D29B4.C40082F2@pcsystems.de>
Date: Sun, 05 Aug 2001 13:10:45 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 3c509: broken(verified)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver for the 3c509 of 2.4.7 is broken:

It is impossible to set the transmitter type.

Loading

modprobe 3c509 xcvr=X, where X is
0,1,2,3,4 doesn't make a difference.

Donald Becker verified that's a driver problem.

Can someone fix that ? Or is there a fix outthere ?

Sincerly,

Nico



Donald Becker wrote:

> On Sun, 5 Aug 2001, Nico Schottelius wrote:
>
> > > > I tried to change the media type of the card,
> > > > but the card didn't accept/recognized what I told
> > > > it!
> > > >
> > > > modprobe 3c509 xcvr=4
> > >
> > > What driver version?  From where?
> >
> > was 1.18 from kernel 2.4.7.
> > ftp.de.kernel.org
>
> Yes, it's broken.
>
> Report the problem on the kernel mailing list.
>
> Donald Becker                           becker@scyld.com
> Scyld Computing Corporation             http://www.scyld.com
> 410 Severn Ave. Suite 210               Second Generation Beowulf Clusters
> Annapolis MD 21403                      410-990-9993

