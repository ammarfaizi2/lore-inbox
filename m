Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269912AbRHGAuj>; Mon, 6 Aug 2001 20:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269701AbRHGAu3>; Mon, 6 Aug 2001 20:50:29 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:56589 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S269836AbRHGAuR>;
	Mon, 6 Aug 2001 20:50:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alan <alan@clueserver.org>
Reply-To: alan@clueserver.org
To: Rodrigo Souza de Castro <rcastro@ime.usp.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with ASUS CUV4X-D board
Date: Mon, 6 Aug 2001 16:49:17 -0700
X-Mailer: KMail [version 1.3]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010805194247.190906E42@clueserver.org> <20010805154417.A691@vinci>
In-Reply-To: <20010805154417.A691@vinci>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010807020437.89DDC6E42@clueserver.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 August 2001 11:44, Rodrigo Souza de Castro wrote:
> On Sun, Aug 05, 2001 at 10:27:34AM -0700, Alan wrote:
> > I am running this under 2.4.3. I will be testing 2.4.7 this afternoon to
> > see if I can fix the problem.
> >
> > The board works fine with a uniprocessor kernel.
> >
> > When booking under the stock mandrake 8.0 kernel, I get cascading error
> > messages about clock problems and blaming a VIA686A chipset.
> >
> > This has a VT82C686B PCI chipset.
> >
> > I tried to find info on the web on this and was not ver successful. 
> > (This is at a friend's house.  He is out in the middle on nowhere and is
> > lucky if he get 28.8k connections.)
> >
> > It this one of the non-correctable VIA chipsets?  Is there a workaround
> > for this?
> >
> > It is a dual P-III 733 with a gig of ram. I would hate to see it go to
> > waste. (Actually it will because it is not at MY house, but that is
> > another problem. ]:> )
> >
> > I was going to get one of these boards. I am glad I did not...
>
> 	I have this board with a dual P-III 1 GHz and it works fine
> with 2.4.7. Make sure you have at least revision 1007A for you BIOS
> (the latest is 1010) and disable MPS 1.4 in BIOS configuration.

The BIOS version was 1010. 

Disabling MPS 1.4 fixed the problem!

Thank you very much!


