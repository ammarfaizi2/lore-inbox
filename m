Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbTBIUwn>; Sun, 9 Feb 2003 15:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbTBIUwn>; Sun, 9 Feb 2003 15:52:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57003
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267449AbTBIUwl>; Sun, 9 Feb 2003 15:52:41 -0500
Subject: Re: 2.4.21-pre4 comparison bugs (More of those)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030209175349.GA20635@linuxhacker.ru>
References: <20030208171838.GA2230@linuxhacker.ru>
	 <1044752320.18908.18.camel@irongate.swansea.linux.org.uk>
	 <20030209175349.GA20635@linuxhacker.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044828089.30767.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Feb 2003 22:01:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-09 at 17:53, Oleg Drokin wrote:
> This time I changed the type of variable to signed type whenever
> I felt it was appropriate.
> When I was not sure (or unsigned type was in some commonly used
> structure), I still used a cast just to highlight a problem, so that someone
> more knowledgeable created better fix.
> See the patch.
> Mostly we do incorrect stuff on errors. Sigh, nobody likes errors ;)

Hiding them is even worse than having them there visible and unfixed.
Changing the sign on stuff holding physical addresses is actually
introducing real bugs


