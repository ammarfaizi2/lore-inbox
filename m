Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318730AbSHLPuC>; Mon, 12 Aug 2002 11:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318731AbSHLPuC>; Mon, 12 Aug 2002 11:50:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:17661 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318730AbSHLPuB>; Mon, 12 Aug 2002 11:50:01 -0400
Subject: Re: 2.5.31 hda: lost interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Irwan Hadi <irwanhadi@phxby.engr.usu.edu>
Cc: Kees Bakker <kees.bakker@altium.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20020812153125.GA29884@phxby.com>
References: <15703.24219.318219.380751@koli.tasking.nl> 
	<20020812153125.GA29884@phxby.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 16:50:56 +0100
Message-Id: <1029167456.16421.174.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 16:31, Irwan Hadi wrote:
> Well on my machine, with Maxtor DiamondMax 40 and Asus A7A255 ->
> AliMagic chipset, and with kernel 2.5.26 I was having the same problem
> too.
> It seems the problem might be because I was using ext3fs, which soon I
> found out corrupt the filesystem because of this lost interrupt thing.
> Or this problem might occur because my system is an AMD Athlon.

It happened because you ran 2.5. IDE on 2.5 is not stable (especially on
2.5.26)

> My solution was to move back to ext2fs and kernel 2.4.18, although for
> this I needed to fsck the hard drive a couple times because of the
> occured corruption to the filesystem.

ext3 is stable on 2.4 systems. 


