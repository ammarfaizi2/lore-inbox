Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281192AbRKTSHr>; Tue, 20 Nov 2001 13:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281193AbRKTSHh>; Tue, 20 Nov 2001 13:07:37 -0500
Received: from mout1.freenet.de ([194.97.50.132]:13762 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S281192AbRKTSHQ>;
	Tue, 20 Nov 2001 13:07:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Wolfgang Rohdewald <WRohdewald@dplanet.ch>
Reply-To: WRohdewald@dplanet.ch
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>,
        root@chaos.analogic.com
Subject: Re: Swap
Date: Tue, 20 Nov 2001 18:58:03 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.3.95.1011120111730.7650A-100000@chaos.analogic.com> <3BFA8F87.9FB4C13E@nortelnetworks.com>
In-Reply-To: <3BFA8F87.9FB4C13E@nortelnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011120175804.30794332@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 November 2001 18:14, Christopher Friesen wrote:
> "Richard B. Johnson" wrote:
> > On Tue, 20 Nov 2001, Wolfgang Rohdewald wrote:
> > > On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > > > When a page is deleted for one executable (because we can re-read it
> > > > from on-disk binary), it is discarded, not paged out.
> > >
> > > What happens if the on-disk binary has changed since loading the
> > > program? -
> >
> > It can't. That's the reason for `install` and other methods of changing
> > execututable files (mv exe-file exe-file.old ; cp newfile exe-file).
> > The currently open, and possibly mapped file can be re-named, but it
> > can't be overwritten.
>
> Actually, with NFS (and probably others) it can.  Suppose I change the file
> on the server, and it's swapped out on a client that has it mounted.  When
> it swaps back in, it can get the new information.

I am quite sure this is also possible if the binary is emulated by the linux-abi
modules like my old SCO binaries. I just cannot check right now because I did
not yet get linux-abi working with 2.4.15-pre7 (worked with 2.4.15-pre4, but
pre4 had a seemingly VM related OOPS when starting VMware3 which is gone with pre7)

