Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262564AbRFOU5e>; Fri, 15 Jun 2001 16:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262468AbRFOU5Y>; Fri, 15 Jun 2001 16:57:24 -0400
Received: from quattro.sventech.com ([205.252.248.110]:45064 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S264035AbRFOU5O>; Fri, 15 Jun 2001 16:57:14 -0400
Date: Fri, 15 Jun 2001 16:52:04 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kelledin Tane <runesong@earthlink.net>, linux-kernel@vger.kernel.org
Subject: Re: drivers/usb/ov511.c does not compile
Message-ID: <20010615165204.C30332@sventech.com>
In-Reply-To: <20010615160518.A30332@sventech.com> <E15B0IP-00073f-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E15B0IP-00073f-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jun 15, 2001 at 09:34:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > the developer's blessing on this, and also nice to know exactly what
> > > version number to give this driver in 2.4.5 stock.
> > 
> > This has already been fixed in the 2.4.5 pre patches.
> 
> .6 I assume.

Yes, you're absolutely correct. Typo on my part.

> ov511 still has some bad bugs in it - it doesnt work with some uhci drivers
> and it also does precisely the wrong thing when you set the capture size and
> breaks stuff like ffserver. The comments are right but the code picks the
> size which is bigger than the capture, not the nearest smaller size..

Hmm, I'll see if I can produce a patch to fix that.

JE

