Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbRETCwV>; Sat, 19 May 2001 22:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbRETCwL>; Sat, 19 May 2001 22:52:11 -0400
Received: from lpce017.lss.emc.com ([168.159.62.17]:36612 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261392AbRETCwF>; Sat, 19 May 2001 22:52:05 -0400
Date: Sat, 19 May 2001 22:51:17 -0400
Message-Id: <200105200251.f4K2pHT02925@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <Pine.GSO.4.21.0105192232560.7162-100000@weyl.math.psu.edu>
In-Reply-To: <200105200222.f4K2Mto02608@mobilix.ras.ucalgary.ca>
	<Pine.GSO.4.21.0105192232560.7162-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Sat, 19 May 2001, Richard Gooch wrote:
> 
> > The transaction(2) syscall can be just as easily abused as ioctl(2) in
> > this respect. People can pass pointers to ill-designed structures very
> 
> Right. Moreover, it's not needed. The same functionality can be
> trivially implemented by write() and read(). As the matter of fact,
> had been done in userland context for decades. Go and buy
> Stevens. Read it. Then come back.

I don't need to read it. Don't be insulting. Sure, you *can* use a
write(2)/read(2) cycle. But that's two syscalls compared to one with
ioctl(2) or transaction(2). That can matter to some applications.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
