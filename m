Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133004AbRAVTyu>; Mon, 22 Jan 2001 14:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133096AbRAVTyl>; Mon, 22 Jan 2001 14:54:41 -0500
Received: from monza.monza.org ([209.102.105.34]:54544 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S133004AbRAVTy0>;
	Mon, 22 Jan 2001 14:54:26 -0500
Date: Mon, 22 Jan 2001 11:54:10 -0800
From: Tim Wright <timw@splhi.com>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mainboard with Serverworks HE Chipset
Message-ID: <20010122115410.A9425@scutter.sequent.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Matthias Schniedermeyer <ms@citd.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0101170020001.811-100000@citd.owl.de> <20010118145001.B7612@scutter.sequent.com> <20010120122637.A11826@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010120122637.A11826@citd.de>; from ms@citd.de on Sat, Jan 20, 2001 at 12:26:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,
this seems to confirm my suspicion that there's some incompatibility between
the NMI watchdog code and the Serverworks chipset. Still trying to find out
exactly what's wrong...

Tim

On Sat, Jan 20, 2001 at 12:26:37PM +0100, Matthias Schniedermeyer wrote:
> > You could try booting with 'nmi_watchdog=0' and see what happens.
> 
> Since i "append"ed it into the lilo-confi i haven't had a lockup. :-))
> 
> 
> 
> Bis denn
> 
> -- 
> Real Programmers consider "what you see is what you get" to be just as 
> bad a concept in Text Editors as it is in women. No, the Real Programmer
> wants a "you asked for it, you got it" text editor -- complicated, 
> cryptic, powerful, unforgiving, dangerous.
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
