Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281224AbRKPHne>; Fri, 16 Nov 2001 02:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281225AbRKPHnZ>; Fri, 16 Nov 2001 02:43:25 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:60800 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281224AbRKPHnL>; Fri, 16 Nov 2001 02:43:11 -0500
Date: Fri, 16 Nov 2001 01:45:28 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Microsoft IE6 is crashing with Linux 2.4.X
Message-ID: <20011116014528.A22819@vger.timpanogas.org>
In-Reply-To: <002501c16e0c$d3800550$f5976dcf@nwfs> <1005854832.2730.1.camel@heat> <000001c16e6c$c29061d0$f5976dcf@nwfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000001c16e6c$c29061d0$f5976dcf@nwfs>; from jmerkey@timpanogas.org on Thu, Nov 15, 2001 at 02:45:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The mail server was down for over 9 hours today.  Suffice to say if 
you are using RedHat Seawolf with Sendmail 8.11.X you need to upgrade 
to 8.12.00 and enable UseMSP=Yes and set up the indirect submission
methods for smmsp:smmsp.  I used tcpdump and determined that IE6 will 
send "hidden" emails to addresses at msn.com (they appeared random).  I 
have no idea why it is doing this, but these emails appeared to contain 
system level information.  There was also obvious (and very nasty) packet 
corruption from IE6 that sendmail 8.11.X does not handle very well at all
whe it gets these corrupted packets.  

Mail server up.  IE6 in the trash can.  We'll try this one at a later date.
Need to warn Linux users that IE6 is severely broken and can result in 
severe crashes on Linux systems.  It also caused a W2K server to crash and 
blue screen as well today.  My mail server was non-functional for most 
of the afternoon due to IE6 mail clients in the building periodically 
causing email flood storms on Seawolf with Sendmail 8.11.X and Linux 
2.4.14.

Jeff


On Thu, Nov 15, 2001 at 02:45:39PM -0700, Jeff V. Merkey wrote:
> According to some folks who responded to this, IE6 is just plain broken.  I
> apologize for the lateness of responding, but my Linux server crashed with
> sendmail spawing thread after thread and my /var/spool/mqueue directory
> filled to bursting with corrupted mail headers.  IE6 got into some kind of
> braindead loop where it started flooding sendmail with tons of bogus (and
> garbage) mail headers.
> 
> It's clearly a piece of sh_t browser.  This latest release qualifies as a
> computer virus.  It's much more destructive that lion every dreamed of
> being.
> 
> Jeff
> 
> 
> ----- Original Message -----
> From: "Jeffrey W. Baker" <jwbaker@acm.org>
> To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Thursday, November 15, 2001 1:07 PM
> Subject: Re: Microsoft IE6 is crashing with Linux 2.4.X
> 
> 
> > On Thu, 2001-11-15 at 11:35, Jeff V. Merkey wrote:
> > >
> > > I have upgraded several W2K boxes to the latest IE6 packages I
> downloaded
> > > from Microsoft's website.  I am seeing a behavior which appears to be a
> bug.
> >
> > Be a lot more interesting email if you included a dump of the actual
> > network traffic.  -jwb
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
