Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262597AbREOBp6>; Mon, 14 May 2001 21:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262599AbREOBpi>; Mon, 14 May 2001 21:45:38 -0400
Received: from femail19.sdc1.sfba.home.com ([24.0.95.128]:37536 "EHLO
	femail19.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262597AbREOBpc>; Mon, 14 May 2001 21:45:32 -0400
Message-ID: <3B008D00.A201D690@didntduck.org>
Date: Mon, 14 May 2001 21:57:20 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 kernel reports wrong amount of physical memory
In-Reply-To: <200105142250.f4EMoHt02203@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <Pine.LNX.4.33.0105142025000.18102-100000@duckman.distro.conectiva> <9dpt1e$185$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Followup to:  <Pine.LNX.4.33.0105142025000.18102-100000@duckman.distro.conectiva>
> By author:    Rik van Riel <riel@conectiva.com.br>
> In newsgroup: linux.dev.kernel
> >
> > On Mon, 14 May 2001, Wayne Whitney wrote:
> > > In mailing-lists.linux-kernel, you wrote:
> > >
> > > > You need to compile highmem support into the kernel if you want to
> > > > use more than 890 MB of RAM, set it to maximum 4GB for best
> > > > performance...
> > >
> > > On a similar note, what is the maximum physical memory supported
> > > by the 4GB option?
> >
> > Ummm, 4GB maybe? ;)
> >
> 
> It seems obvious once you know why the limits are there.  The 1 GB
> limit (actually 1024-128 MB = 896 MB) is a software limit; the 4 GB
> and 64 GB limits are hardware limits and are exact.

Even with the 4GB and 64GB options, some physical address space has to
be reserved for memory mapped I/O.

--
					Brian Gerst
