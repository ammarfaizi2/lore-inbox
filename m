Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265395AbSJRVq2>; Fri, 18 Oct 2002 17:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbSJRVq2>; Fri, 18 Oct 2002 17:46:28 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:49169 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265395AbSJRVq1>;
	Fri, 18 Oct 2002 17:46:27 -0400
Date: Fri, 18 Oct 2002 14:51:57 -0700
From: Greg KH <greg@kroah.com>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch for linux/usb.h
Message-ID: <20021018215157.GA10444@kroah.com>
References: <20021018212532.GE32609@net-m.de> <20021018213521.GA10351@kroah.com> <20021018214519.GF32609@net-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018214519.GF32609@net-m.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 11:45:19PM +0200, Wiktor Wodecki wrote:
> > > +} urb_t;
> > > -};
> > 
> > No, that's not "missing" it was taken out because it should have never
> > gotten there in the first place.
> 
> hmmm, it might "not be a good thing" to change an interface in a stable
> kernel series. this, for example, broke my quickcam express video cam
> driver. It might be wrong there, however I think we should leave it
> there...not apply this to 2.5 then

Sorry, but I fixed up all in-kernel instances of this usage.  If you
want to keep a driver outside of the main kernel tree, you're going to
have to get used to things like this.  In fact, this is a very minor
change, wait until some of the other USB API changes that have happened
in 2.5 get backported to 2.4 :)

Good luck,

greg k-h
