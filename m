Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279892AbRJ3HqD>; Tue, 30 Oct 2001 02:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279893AbRJ3Hpx>; Tue, 30 Oct 2001 02:45:53 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:28667
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279892AbRJ3Hpr>; Tue, 30 Oct 2001 02:45:47 -0500
Date: Mon, 29 Oct 2001 23:46:15 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neale Banks <neale@lowendale.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
Message-ID: <20011029234615.A14476@mikef-linux.matchmail.com>
Mail-Followup-To: Neale Banks <neale@lowendale.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <Pine.LNX.4.05.10110301839250.23080-100000@marina.lowendale.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.05.10110301839250.23080-100000@marina.lowendale.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 06:46:03PM +1100, Neale Banks wrote:
> On Mon, 29 Oct 2001, Alan Cox wrote:
> 
> > > and received a nasty surprise. The uptime, which had been 496+ days
> > > on Friday, was back down to a few hours. I was ready to lart somebody
> > > with great vigor when I realized the uptime counter had simply wrapped
> > > around.
> > > 
> > > So, I thought to myself, at least the 2.4 kernels on our new boxes won't
> > 
> > It wraps at 496 days. The drivers are aware of it and dont crash the box
> 
> You mean there was a time when uptime>496days would crash a system?
> 
> If so, approximtely when did that get fixed?
> 
> (I'm thinking back to an as yet unexplained crash of a 2.0.38 system at
> ~496days uptime :-( )
> 

AFAIK, the system didn't crash, but the uptime counter went down to zero.
