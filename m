Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315985AbSETNlu>; Mon, 20 May 2002 09:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSETNlt>; Mon, 20 May 2002 09:41:49 -0400
Received: from pc16-84.hiof.no ([158.36.16.84]:11392 "EHLO pompel.gruppe5.net")
	by vger.kernel.org with ESMTP id <S315985AbSETNls>;
	Mon, 20 May 2002 09:41:48 -0400
Message-ID: <3CE8FCDC.721DFC5D@hiof.no>
Date: Mon, 20 May 2002 15:40:44 +0200
From: Jens-Christian Skibakk <jens.c.skibakk@hiof.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19-pre8-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: morten.helgesen@nextframe.net
CC: Jens Christian Skibakk <jenscski@sylfest.hiof.no>,
        linux-kernel@vger.kernel.org
Subject: Re: EXT3-fs error (device ide0(3,77)) in ext3_new_inode: error 28
In-Reply-To: <Pine.LNX.4.44.0205201400490.11918-100000@sylfest.hiof.no> <20020520142325.B143@sexything>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The df -i shows that there are now unused inodes.

SO I need to reformat my hd to have more inodes?

Jens-Chr.


Morten Helgesen wrote:
> 
> On Mon, May 20, 2002 at 02:07:34PM +0200, Jens Christian Skibakk wrote:
> >
> > When I unpack a tar-archive containing many files (about halv a million)
> > this errors occures in the dmesg output:
> > EXT3-fs error (device ide0(3,77)) in ext3_new_inode: error 28
> >
> > and the program complins about: No space left on device, but df -h shows
> > that there is over 1G free on the hd.
> 
> Can you please paste the output from 'df -h' and 'df -i' ?
> 
> >
> > After this error occurs the hd contains errors and need to be checked.
> >
> > The filesystem on the hd is ext3.
> >
> > I have tested this with to kernel-verions, on both 2.4.18 and
> > 2.4.19-pre8-ac3 the error occurs.
