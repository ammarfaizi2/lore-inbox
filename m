Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315048AbSD2KnS>; Mon, 29 Apr 2002 06:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315050AbSD2KnR>; Mon, 29 Apr 2002 06:43:17 -0400
Received: from imladris.infradead.org ([194.205.184.45]:45576 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315048AbSD2KnP>; Mon, 29 Apr 2002 06:43:15 -0400
Date: Mon, 29 Apr 2002 11:43:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: snpe <snpe@snpe.co.yu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ABI & SMP
Message-ID: <20020429114312.A3627@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	snpe <snpe@snpe.co.yu>, linux-kernel@vger.kernel.org
In-Reply-To: <200204271227.06609.snpe@snpe.co.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 12:27:06PM +0200, snpe wrote:
> Hello,
>    I have kernel 2.4.17 and abi 2.4.17 patch
> I have used aplication (oracle sqlforms30, runmenu for sco 5, coff).
> Hardware is Compaq Proliant 1600 with 2 processors.
> If I use kernel with one processor all is ok, but with SMP kernel
> I have problem.
> Application work btw one hour and then I get segmentation fault.
> I am tried unload moduls and load again without success.
> After reset all work one hour ...

Do you have any OOPS message or something like that?  Also a trace
(echo 0xffff > /proc/sys/abi/trace) would be nice to find out the
last emulated syscall.
