Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277435AbRK0MLU>; Tue, 27 Nov 2001 07:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRK0MLK>; Tue, 27 Nov 2001 07:11:10 -0500
Received: from ns.ithnet.com ([217.64.64.10]:43023 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S277514AbRK0MKx>;
	Tue, 27 Nov 2001 07:10:53 -0500
Date: Tue, 27 Nov 2001 13:10:09 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: Didier.Moens@dmb001.rug.ac.be, abraham@2d3d.co.za,
        linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
Message-Id: <20011127131009.08b75571.skraw@ithnet.com>
In-Reply-To: <3C037C73.3090003@epfl.ch>
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be>
	<3C022BB4.7080707@epfl.ch>
	<1006808870.817.0.camel@phantasy>
	<3C02BF41.1010303@xs4all.be>
	<20011127101148.C5778@crystal.2d3d.co.za>
	<3C034CAE.2090103@dmb.rug.ac.be>
	<3C036F83.2000903@dmb.rug.ac.be>
	<3C037C73.3090003@epfl.ch>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001 12:43:47 +0100
Nicolas Aspert <Nicolas.Aspert@epfl.ch> wrote:

> > If there are no further complaints we should submit the patch. What do you
> > think Nicolas?
> > 
> 
> Well, I prefer my version on the patch (of course :-), 

Guess what: I expected that :-)

>and I find it 
> cleaner. Let me explain why : by just adding the 'break', you will fall 
> back to the generic initialization routines, which work in most of the 
> cases. However, if you look deeper the code & the specs, they are not 
> really that good.

I re-read the code according to your notes. Since I do not have the docs at
hand I am going to trust your word and indeed believe your patch is cleaner.
Only a personal add-on: make it a bit less verbosely talking to the user ;-) I
think we do not need to tell him three times he has i830. One line should be
sufficient. But obviously thats nothing of real importance.


> However, before submitting the patch, I would like to hear from Didier 
> about the X server stuff.
> Does it still hard-locks when you start it ? If testgart works (which 
> seems to be the case... btw, yes the 8MB alloced by the program are 
> normal) and X locks, this would look more like a DRI/X problem (I saw 
> some problems w. Radeon cards on the dri-devel list, which do not seem 
> to be fully solved yet)

This really looks like an X issue to me and not related to agp.

Thanks for your support, Nicolas.

Regards,
Stephan

PS: you propose the patch to l & m :-) we killed yet another oops.










