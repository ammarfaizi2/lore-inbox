Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbTC0TPI>; Thu, 27 Mar 2003 14:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbTC0TPI>; Thu, 27 Mar 2003 14:15:08 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48136 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261346AbTC0TPG>;
	Thu, 27 Mar 2003 14:15:06 -0500
Date: Thu, 27 Mar 2003 11:25:18 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030327192517.GJ32667@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E83459A.3090803@portrix.net> <20030327185222.GI32667@kroah.com> <1048792523.7569.102.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048792523.7569.102.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 09:15:23PM +0200, Martin Schlemmer wrote:
> On Thu, 2003-03-27 at 20:52, Greg KH wrote:
> 
> > > Is this the way you want to go? Just an example for the voltages.
> > 
> > That looks very good to me, nice 
> 
> While we are at it, some form question.  The w83781d have a
> magnitude of files in sysfs if you split them like this, so
> I went for the shorter (easier?) way.
> 
> This ok, or should I split it up a bit more.  Note that I
> have not done much for indentation yet.

This is fine with me, whatever works for you.  Either way, we are
abusing macros a bunch :)

thanks,

greg k-h
