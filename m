Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314275AbSECP2r>; Fri, 3 May 2002 11:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314328AbSECP2r>; Fri, 3 May 2002 11:28:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:42000 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S314275AbSECP2q> convert rfc822-to-8bit; Fri, 3 May 2002 11:28:46 -0400
Date: Fri, 3 May 2002 11:27:38 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre8
In-Reply-To: <200205031516.29892.Dieter.Nuetzel@hamburg.de>
Message-ID: <Pine.LNX.4.21.0205031123290.10896-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 May 2002, Dieter [iso-8859-15] Nützel wrote:

> Sorry for my ignorance Marcelo,
> 
> but why don't we see the "outstanding" VM fixes even if the -19 cycle is so 
> long, then?

Andrea VM changes are touching performance and stability critical parts of
the code. I cannot simply merge of all them at one time.

What I'm doing is to merge each part separately (for example, 2.4.19 will
have the writeout scheduling changes) so they can be tested separately by
lots of people when final releases are done.

Also I'm trying to understand his changes. I'm not going to merge
senseless stuff.

The writeout scheduling changes were excellent.

> So we see posts like "...hurray, the O(1)-scheduler is so much faster..." and 
> "...-jam6, too..." (including the spiltted vm33), etc.
>
> All this numbers are known for months.
> 
> Do you think the pending VM stuff goes into -20, at least?

Hopefully.

