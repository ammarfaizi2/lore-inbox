Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273796AbRIYVUq>; Tue, 25 Sep 2001 17:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273502AbRIYVUg>; Tue, 25 Sep 2001 17:20:36 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:8459 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S273796AbRIYVU3>;
	Tue, 25 Sep 2001 17:20:29 -0400
Date: Tue, 25 Sep 2001 14:16:23 -0700
From: Greg KH <greg@kroah.com>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <20010925141623.A14962@kroah.com>
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com> <20010925084439.B6396@us.ibm.com> <20010925200947.B7174@itsolve.co.uk> <20010925134232.A14715@kroah.com> <3BB0F297.D4A9E986@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB0F297.D4A9E986@drugphish.ch>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 11:09:43PM +0200, Roberto Nibali wrote:
> 
> If you're dealing with argus, ask straight for developers or technical
> people not resellers.

I did just directly email them.  Thanks for letting me know.

> The second problem is that they ceased making their
> Pitbull LX product available for download on the web for some reasons.
> Since I work with argus-system products sometime I got the chance of
> still having a copy of this huge tarball and I made a diff or their
> actual changes to the 2.2.19 kernel for you. Unfortunately I had to
> put it onto a non- argus related development site and I will leave it
> there for the next 12 hours. Grab it, analyse it and convince yourself
> that they actually go quite into the direction of the LSM framework
> approach. Actually I talked to one of the argus technical guys about a
> possible port to the LSM frame- work and he said that they are going
> to look into it. Of course the lkm with the real security
> functionality is binary only. Decide yourself ...

Thank you for putting this up.  It looks like they are placing hooks all
through the kernel, much like the LSM patch does.

And since they are patching the kernel to provide hooks for their
security module, they should also release that security module source
code to remain legal.

Thanks again.

greg k-h
