Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSGHCMF>; Sun, 7 Jul 2002 22:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316728AbSGHCME>; Sun, 7 Jul 2002 22:12:04 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:6927 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316723AbSGHCME>;
	Sun, 7 Jul 2002 22:12:04 -0400
Date: Sun, 7 Jul 2002 19:12:29 -0700
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Thunder from the hill <thunder@ngforever.de>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020708021228.GA19336@kroah.com>
References: <Pine.LNX.4.44.0207071551180.10105-100000@hawkeye.luckynet.adm> <3D28C3F0.7010506@us.ibm.com> <20020707235114.GE18298@kroah.com> <3D28D7A9.5010409@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D28D7A9.5010409@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 10 Jun 2002 00:24:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 05:07:05PM -0700, Dave Hansen wrote:
> 
> You are taking this example way too seriously.  Thunder wanted an 
> example and I grabbed the first one that I saw (I created it in the 
> last hour).  I showed you how I arrived at it, just a quick grepping. 
>  It wan't a real patch, only a quick little example snippet.

I know that, you're taking my response way too seriously :)
I just showed the typical response to one of your posts, you just picked
the wrong example, or maybe any USB example you could have picked would
have evicted much the same response :)

> >	- even if you remove the BKL from this code, what have you
> >	  achieved?  A faster kernel?  A very tiny bit smaller kernel,
> >	  yes, but not any faster overall.  This is not on _any_
> >	  critical path.
> 
> How many times do I have to say it?  We're going around in circles 
> here.  I _know_ that it isn't on a critical path, or saving a large 
> quantity of program text.  I just think that it is better than it was 
> before.

So you agree with me?  Good.  I know you think the code is better than
it was before, but beauty is in the eye of the beholder, or in this
case, the eye of the people that fully understand the code :)

If nothing else, I hope you will think twice before sending off your
next BKL removel patch in a subsystem that you haven't fully tested or
understood.  That's the point I keep trying to get across here.

thanks,

greg k-h
