Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267036AbSKLXsT>; Tue, 12 Nov 2002 18:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbSKLXsT>; Tue, 12 Nov 2002 18:48:19 -0500
Received: from polomer.sinet.sk ([62.169.169.8]:30739 "EHLO polomer.sinet.sk")
	by vger.kernel.org with ESMTP id <S267031AbSKLXsS>;
	Tue, 12 Nov 2002 18:48:18 -0500
From: Peter Kundrat <kundrat@kundrat.sk>
Date: Wed, 13 Nov 2002 00:52:56 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio
Message-ID: <20021112235255.GA7015@napri.sk>
Mail-Followup-To: kundrat,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211121802540.27793-100000@graze.net> <1037144284.10029.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037144284.10029.0.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 11:38:04PM +0000, Alan Cox wrote:
> On Tue, 2002-11-12 at 23:06, Brian C. Huffman wrote:
> > Alan / All,
> > 
> > 	I assume this is the patch that's been in your -ac kernels for a 
> > while?  I have an Intel 845GBV board which uses the ICH4 architecture.  
> > I'm happy to report that this patch does allow me to use the integrated 
> > sound on this motherboard, but one thing that I've noticed is that it 
> > seems as though to adjust volume you need to adjust the actual channel 
> > (PCM, CD, etc), rather than main volume.  Any ideas why this might be so?
> 
> It could be the mixer on your board doesnt support main volume control.
> The i8xx audio is half of a whole, it deals with transferring streams of
> audio data and mixer requests down an AC'97 audio bus to a codec which
> does the D/A parts. That codec varies by board.

My board (i815) has also i810 onboard audio and the main control doesnt
work too (i had problmes getting it working with oss driver, but didnt
have much time trying different kernels). 

What works as a main control, though, is control labelled Headphones 
(in alsamixer). 

pkx

-- 
Peter Kundrat
peter@kundrat.sk
