Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbRETCT0>; Sat, 19 May 2001 22:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbRETCTH>; Sat, 19 May 2001 22:19:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32525 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261334AbRETCS6>;
	Sat, 19 May 2001 22:18:58 -0400
Date: Sun, 20 May 2001 03:18:07 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010520031807.G23718@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu> <E1517Jf-0008PV-00@the-village.bc.nu> <200105191851.f4JIpNK00364@mobilix.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105191851.f4JIpNK00364@mobilix.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sat, May 19, 2001 at 12:51:23PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 12:51:23PM -0600, Richard Gooch wrote:
> Al, if you really want to kill ioctl(2), then perhaps you should
> implement a transaction(2) syscall. Something like:
>     int transaction (int fd, void *rbuf, size_t rlen,
> 		     void *wbuf, size_t wlen);
> 
> Of course, there wouldn't be any practical gain, since we already have
> ioctl(2). Any gain would be aesthetic.

I can tell you haven't had to write any 32-bit ioctl emulation code for
a 64-bit kernel recently.

-- 
Revolutions do not require corporate support.
