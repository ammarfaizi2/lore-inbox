Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318931AbSHEXSJ>; Mon, 5 Aug 2002 19:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318932AbSHEXSJ>; Mon, 5 Aug 2002 19:18:09 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:52239 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318931AbSHEXSI>;
	Mon, 5 Aug 2002 19:18:08 -0400
Date: Mon, 5 Aug 2002 16:19:15 -0700
From: Greg KH <greg@kroah.com>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] integrate driverfs and devfs (2.5.28)
Message-ID: <20020805231914.GF29396@kroah.com>
References: <Pine.LNX.4.44.0207291431381.22697-100000@cherise.pdx.osdl.net> <200207292326.g6TNQcI19062@fachschaft.cup.uni-muenchen.de> <200208051225.g75CP4v316564@pimout4-ext.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208051225.g75CP4v316564@pimout4-ext.prodigy.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 08 Jul 2002 21:20:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 02:26:35AM -0400, Rob Landley wrote:
> 
> So what's root_dev_names in init/do_mounts.c?  If a default naming policy is 
> so unacceptably evil, is that being removed in 2.5 and everybody being told 
> to use major/minor for the root device?

Yes.  Well no.  We can't break backwards compatibility with userspace
like this.  So things like root device naming will have to live on for a
while.

> By the way, why doesn't imposing consistent predefined major/minor numbers 
> (0x0301 instead of "hda1") count as "policy"?   I'm honestly curious...

It does.  I want to get rid of it too :)  But that's still a ways away...

thanks,

greg k-h
