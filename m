Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317481AbSF1VXx>; Fri, 28 Jun 2002 17:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSF1VXw>; Fri, 28 Jun 2002 17:23:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14864 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317481AbSF1VXw>; Fri, 28 Jun 2002 17:23:52 -0400
Date: Fri, 28 Jun 2002 17:31:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
In-Reply-To: <20020628145406.A17560@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0206281730160.12542-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ivan,

I just backed it on my BK repository.

Please test now.


On Fri, 28 Jun 2002, Ivan Kokshaysky wrote:

> Hi Marcelo, Alan,
>
> IIRC, the problem is that BSD and OSF readv/writev(2) manuals
> explicitly talked of 32 bit iov_len, thus allowing the application
> to pass junk in an upper half of the 64 bit word.
> This change broke widely used netscape and acrobat reader,
> please revert it until we have a better solution:
>
> <alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.37)
> 	[PATCH] PATCH; make readv/writev SuS compliant
>
> Ivan.
>

