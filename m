Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSIEGzw>; Thu, 5 Sep 2002 02:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSIEGzw>; Thu, 5 Sep 2002 02:55:52 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:13584 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317117AbSIEGzv>;
	Thu, 5 Sep 2002 02:55:51 -0400
Date: Wed, 4 Sep 2002 23:58:25 -0700
From: Greg KH <greg@kroah.com>
To: Peter <cogweb@cogweb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-ac4 build problem
Message-ID: <20020905065825.GA10140@kroah.com>
References: <Pine.LNX.4.44.0209032237460.25475-100000@greenie.frogspace.net> <Pine.LNX.4.44.0209042038490.13193-100000@greenie.frogspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209042038490.13193-100000@greenie.frogspace.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 08:59:55PM -0700, Peter wrote:
> 
> > Hm, I think you will have to compile the input stuff into the core, if
> > you want your USB input drivers to link properly.  So there's really no
> > way around this.
> 
> In that case, why don't we remove the choice to make modules in input core
> support? 

No, because it works just fine when you build the USB drivers as
modules, and the Input core as modules, which is what the majority of
people do.

> If there's some reason to keep it, let's save someone some grief and add a
> note to CONFIG_INPUT:
> 
> Note that in most cases, input support must be compiled into the core for
> your USB input drivers to link properly.

Again, not true.  It just has to match the same value for the USB input
drivers.  A patch with this kind of wording would be greatly
appreciated.

thanks,

greg k-h
