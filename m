Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133043AbRDLCuO>; Wed, 11 Apr 2001 22:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133044AbRDLCuE>; Wed, 11 Apr 2001 22:50:04 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:20011 "EHLO
	golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S133043AbRDLCtw>; Wed, 11 Apr 2001 22:49:52 -0400
Date: Wed, 11 Apr 2001 22:50:55 -0400
From: esr@thyrsus.com
To: jeff millar <jeff@wa1hco.mv.com>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
        "Eric S. Raymond" <esr@snark.thyrsus.com>
Subject: Re: CML2 1.0.0 doesn't remember configuration changes
Message-ID: <20010411225055.A11009@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, jeff millar <jeff@wa1hco.mv.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
	"Eric S. Raymond" <esr@snark.thyrsus.com>
In-Reply-To: <20010411191940.A9081@thyrsus.com> <E14nU6n-0007po-00@the-village.bc.nu> <20010411204523.C9081@thyrsus.com> <002701c0c2f1$fc672960$0201a8c0@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002701c0c2f1$fc672960$0201a8c0@home>; from jeff@wa1hco.mv.com on Wed, Apr 11, 2001 at 09:43:08PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff millar <jeff@wa1hco.mv.com>:
> I'm confused.  Downloaded cml2-1.0.0 installed ran it....appear to work but
> it doesn't remember my changes.  Just now, I updated to 1.0.3 and it
> reported cleaning up existing files.  Ran "make config" and it popped up
> menu under X.  Then I changed the "config policy options" to "expert,
> wizard, tuning" and exited with "save and exit".
> 
> Then re-opened with make config and nothing changed...expert, wizard and
> tuning not set.  Maybe the program _knows_ I'm not a wizard but it should at
> least let me _tune_.  (joke)
> 
> By the way "make editconfig" shows the changes made under "make config" and
> allows me to make more changes..
> 
> The READ.ME says that "make config" will run configtrans to generate
> .config.  But that doesn't explain why "make config"  doesn't remember
> changes made to config.out.
> 
> ideas?
> 
> jeff

I think it's because I misunderstood how the standard productions are supposed
to work.  If you'll tell me what files you expect them to read on startup,
and in what order, I can emulate that behavior.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The possession of arms by the people is the ultimate warrant
that government governs only with the consent of the governed.
        -- Jeff Snyder
