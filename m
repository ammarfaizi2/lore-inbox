Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263330AbTC0RQD>; Thu, 27 Mar 2003 12:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263329AbTC0RP4>; Thu, 27 Mar 2003 12:15:56 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:25608 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263325AbTC0RPF>;
	Thu, 27 Mar 2003 12:15:05 -0500
Date: Thu, 27 Mar 2003 09:25:16 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030327172516.GA32667@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E82D678.9000807@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E82D678.9000807@portrix.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 11:46:16AM +0100, Jan Dittmer wrote:
> >Entry	Values	Function
> >-----	------	--------
> >temp,
> >temp[1-3]  3	Temperature max, min or hysteresis, and input value.
> >	       	Floating point values XXX.X or XXX.XX in degrees Celcius.
> 
> If we're restructuring it, I think we should also agree on _one_ common 
> denominator for all values ie. mVolt and milli-Degree Celsius, so that 
> no userspace program ever again has know how to convert them to 
> user-readable values and every user can just cat the values and doesn't 
> have to wonder if it's centi-Volt, milli-Volt, centi-Degree, dezi-Degree 
> or whatever.

Um, that's what my proposal stated.  Do you not agree with it?  (You're
quoting the existing document above, not my proposed changes.)

thanks,

greg k-h
