Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316616AbSE0Nnr>; Mon, 27 May 2002 09:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316617AbSE0Nnq>; Mon, 27 May 2002 09:43:46 -0400
Received: from [62.70.58.70] ([62.70.58.70]:45445 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316616AbSE0Nnp> convert rfc822-to-8bit;
	Mon, 27 May 2002 09:43:45 -0400
Message-Id: <200205271343.g4RDhOR04448@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] 2.4 VM sucks. Again
Date: Mon, 27 May 2002 15:43:24 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E17BGj9-0006VQ-00@the-village.bc.nu> <200205271112.g4RBCH103186@mail.pronto.tv> <1022509903.11811.282.camel@irongate.swansea.linux.org.uk>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 May 2002 16:31, you wrote:
> On Mon, 2002-05-27 at 12:12, Roy Sigurd Karlsbakk wrote:
> > If I try to do ~50 simultanous reads from disk, it's no problem as long
> > as the data is being read from the nic with the same speed as it's being
> > read from disk. The server apps are running via inetd (testing), and have
> > 2MB of buffer each. (read 2MB from disk, write 2MB to NIC).
> >
> > The server chrashes within minutes. The same problem occurs when using
> > Tux
>
> How much physical memory and is your app using sendfile ?

I have 1gig with highmem disabled, ergo 900MB.

My app is just doing read() write(), but as the problem occurs similarly with 
Tux (which uses sendfile()), it shouldn't really matter

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
