Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132400AbRCaO0f>; Sat, 31 Mar 2001 09:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132402AbRCaO00>; Sat, 31 Mar 2001 09:26:26 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:783 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132400AbRCaO0R>;
	Sat, 31 Mar 2001 09:26:17 -0500
Date: Sat, 31 Mar 2001 16:25:13 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
   Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
   Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Recent problems with APM and XFree86-4.0.1
Message-ID: <20010331162513.C7946@pcep-jamie.cern.ch>
In-Reply-To: <20010331021514.A6784@pcep-jamie.cern.ch> <200103310537.f2V5bDO06729@pcug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103310537.f2V5bDO06729@pcug.org.au>; from sfr@canb.auug.org.au on Sat, Mar 31, 2001 at 03:37:14PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> > On that theme of power management with X problems, I have been having
> > trouble with my laptop crashing when the lid is closed, instead of
> > suspending as it used to.  The laptop is a Toshiba Satellite 4070CDT.
> 
> Can you please try adding
> 	Option	"NoPM"
> to the device section of XF86Config or (XF86Config) and then try suspending
> and resuming.
> 
> This made suspend/resume much more reliable on the Thinkpad 600E with
> XFree86 4.  Also you could try XFree86 4.0.2, as I know that it actually
> does interact with APM (4.0.1 may have as well - I am not sure).

I'll try Option "NoPM", and XFree86 4.0.2 if I can find a conveniently
RH7 compatible RPM.

I should point out that I've been using _some_ version of XFree86 4
since before version 4.0 was released.  (XFree86 3 doesn't support this
laptop's video adapter).  Suspend/resume worked fine and reliably until
recently.

Another problem is that occasionally when X starts now, it will freeze
the system.  So I suspect a bug was introduced in XFree86 4.0.1.

-- Jamie
