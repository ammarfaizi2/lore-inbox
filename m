Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279472AbRKKOdc>; Sun, 11 Nov 2001 09:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281063AbRKKOdX>; Sun, 11 Nov 2001 09:33:23 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:44730 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S279472AbRKKOdK>; Sun, 11 Nov 2001 09:33:10 -0500
Date: 11 Nov 2001 12:06:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8Ce2D-PXw-B@khms.westfalen.de>
In-Reply-To: <20011104211118.U14001@unthought.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.GSO.4.21.0111041502390.21449-100000@weyl.math.psu.edu> <viro@math.psu.edu> <20011104205248.Q14001@unthought.net> <Pine.GSO.4.21.0111041502390.21449-100000@weyl.math.psu.edu> <20011104211118.U14001@unthought.net>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jakob@unthought.net (Jakob ¥stergaard)  wrote on 04.11.01 in <20011104211118.U14001@unthought.net>:
[quoteto.xps]
> On Sun, Nov 04, 2001 at 03:06:27PM -0500, Alexander Viro wrote:
> >
> >
> > On Sun, 4 Nov 2001, [iso-8859-1] Jakob %stergaard wrote:
> >
> > > So just ignore square brackets that have "=" " " and ">" between them ?
> > >
> > > What happens when someone decides  "[---->   ]" looks cooler ?
> >
> > First of all, whoever had chosen that output did a fairly idiotic thing.
> > But as for your question - you _do_ know what regular expressions are,
> > don't you?  And you do know how to do this particular regex without
> > any use of library functions, right?
>
> A regex won't tell me if  345987 is a signed or unsigned 32-bit or 64-bit
> integer,  or if it's a double.

You do not *need* that information at runtime. If you think you do, you're  
doing something badly wrong.

I cannot even imagine what program would want that information.

> Sure, implement arbitrary precision arithmetic in every single app out there
> using /proc....

Bullshit. Implement whatever arithmetic is right *for your problem*. And  
notice when the value you get doesn't fit so you can tell the user he  
needs a newer version. That's all.

There's no reason whatsoever to care what data type the kernel used.

MfG Kai
