Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271791AbRICTsi>; Mon, 3 Sep 2001 15:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271788AbRICTs2>; Mon, 3 Sep 2001 15:48:28 -0400
Received: from unthought.net ([212.97.129.24]:64400 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S271792AbRICTsL>;
	Mon, 3 Sep 2001 15:48:11 -0400
Date: Mon, 3 Sep 2001 21:48:29 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Simon Hay <simon@haywired.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple monitors
Message-ID: <20010903214829.B17488@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Simon Hay <simon@haywired.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3B93CF91.A6D59DA8@haywired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3B93CF91.A6D59DA8@haywired.org>; from simon@haywired.org on Mon, Sep 03, 2001 at 07:44:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 07:44:33PM +0100, Simon Hay wrote:
> Hi all,
> 
> Apologies in advance if this is a question that's already been answered
> somewhere...  I'm looking for a way to install multiple (or rather, two)
> PCI/AGP cards in a machine and connect a monitor to each one, and use
> them both *in console mode* - preferably with some nice way to say
> 'assign virtual console 2 to the first screen, and 5 to the second' -
> that way you could have one tailing log files, showing 'top', whatever. 
> A quick search of the web/newsgroups turned up various patches that
> looked ideal, but a closer inspection revealed that they either relied
> on you having a Hercules mono card, or only applied against kernel
> <0.99, or both...  I was just wondering if anyone's thought
> about/written a similar patch for more recent hardware/versions?  I was
> using a console Linux machine running BB (ASCII art demo -
> http://aa-project.sourceforge.net/) just to attract attention to our
> stand today and was thinking it would be really neat to have one machine
> driving several screens...

XFree86 has pretty good support for multiple heads.

If you tie an xterm to the root window, I guess you would get something
pretty close to what you're looking for.  Or, configure some window manager
properly to do exactly what you want.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
