Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129708AbRBGShx>; Wed, 7 Feb 2001 13:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129988AbRBGShn>; Wed, 7 Feb 2001 13:37:43 -0500
Received: from monza.monza.org ([209.102.105.34]:25604 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129879AbRBGShe>;
	Wed, 7 Feb 2001 13:37:34 -0500
Date: Wed, 7 Feb 2001 10:37:19 -0800
From: Tim Wright <timw@splhi.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Jakub Jelinek <jakub@redhat.com>, Gregory Maxwell <greg@linuxpower.cx>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010207103719.A1037@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	Jakub Jelinek <jakub@redhat.com>,
	Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <20010206182501.A23454@vger.timpanogas.org> <20010206190624.C23960@vger.timpanogas.org> <20010206210731.E1110@xi.linuxpower.cx> <20010207110852.A27089@vger.timpanogas.org> <20010207123213.V16592@devserv.devel.redhat.com> <20010207113147.A27215@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010207113147.A27215@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Wed, Feb 07, 2001 at 11:31:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umm, I don't know what compiler you've got etc. Jeff, but I just tried gcc-2.96
(-69) here, and '#ident' is supported and works perfectly. The only way to even
get a warning is to use '-ansi -pedantic' which yields:
junk.c:1:2: warning: ISO C does not allow #ident

I don't think the problem is with gcc, at least not the Red Hat 7.0 version.

Tim

On Wed, Feb 07, 2001 at 11:31:47AM -0700, Jeff V. Merkey wrote:
> On Wed, Feb 07, 2001 at 12:32:13PM -0500, Jakub Jelinek wrote:
> > On Wed, Feb 07, 2001 at 11:08:52AM -0700, Jeff V. Merkey wrote:
> > > Not supporting #ident for CVS managed code bases would see to 
> > > me, at first glance, to be a show stopper to shipping a release 
> > > of anything, since many folks need CVS support.
> > 
> > Could you please explain what you mean by not supporting #ident?
> > It works just fine for me in all our gcc packages I've checked.
> > 
> > 	Jakub
> 
> It returns an "unknown keyword" error message from the sci source base. 
> Offending source line is in /src/IRM/drv/src/prolog.h in version 
> 1.1-7.  
> 
> Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
