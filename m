Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263156AbTDBSDf>; Wed, 2 Apr 2003 13:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263170AbTDBSDf>; Wed, 2 Apr 2003 13:03:35 -0500
Received: from [81.2.110.254] ([81.2.110.254]:60402 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263156AbTDBSDd>;
	Wed, 2 Apr 2003 13:03:33 -0500
Subject: Re: how to interpret ide error messages (2.4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kiniger, Karl (MED)" <karl.kiniger@med.ge.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030402174117.GA26195@ki_pc2.kretz.co.at>
References: <20030402122324.GA23847@ki_pc2.kretz.co.at>
	 <1049290268.16275.51.camel@dhcp22.swansea.linux.org.uk>
	 <20030402174117.GA26195@ki_pc2.kretz.co.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049303772.14772.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Apr 2003 18:16:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-02 at 18:41, Kiniger, Karl (MED) wrote:
> > On errors the next write to a bad sector will typically remap it
> > transparently to another spare block on the disk. Read obviously cannot
> > do the same. That would mean that if for example clearcase ignored the
> > I/O error and wrote back what it thought it saw but did not that it may
> > have recovered the sector with invalid data. Its also possible of course
> > clearcase actually handles I/O errors properly (which is hard).
> Since it is a raid1 I expected user space not being affected.

I didn't realise it was rai1. If it is raid1 you are right, the upper
layer will supply the data from the other drive

> (The other drive did not show any error messages since installation,
> they are Maxtors 6Y120L0 (120 GB) cooled quite well) So I thought that
> ClearCase should not have seen any error return code.

Correct


