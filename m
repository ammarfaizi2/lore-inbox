Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbTC0IMW>; Thu, 27 Mar 2003 03:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbTC0IMW>; Thu, 27 Mar 2003 03:12:22 -0500
Received: from dc-mx01.cluster1.charter.net ([209.225.8.11]:60378 "EHLO
	dc-mx01.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S261805AbTC0IMV>; Thu, 27 Mar 2003 03:12:21 -0500
Date: Thu, 27 Mar 2003 03:23:29 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH] Logitech USB mice/trackball extensions
Message-ID: <20030327082329.GA3200@cy599856-a>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200303261654.08896.bhards@bigpond.net.au> <200303261727.48908.bhards@bigpond.net.au> <20030327070301.GA3953@BL4ST>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327070301.GA3953@BL4ST>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.5.66-mm1 i686
X-Processor: Athlon XP 2000+
X-Uptime: 03:15:57  up  1:26,  3 users,  load average: 0.33, 0.09, 0.03
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Wed, Mar 26, 2003 at 11:03:01PM -0800, Eric Wong wrote:
> Brad Hards <bhards@bigpond.net.au> wrote:
> > > Doing it in kernel space with module options is gross. This is clearly a
> > > case for userspace.
> > >
> > > See:
> > > http://www.linmagau.org/modules.php?name=Sections&op=viewarticle&artid=40
> > 
> > And for those who actually want the code:
> > http://www.frogmouth.net/logitech-applet-0.2.tar.gz
> 
> Cool, works great!
> 

Ok, the file is there now.  Thanks.  One question though, is this expected
behavior from the MX700?

 $ ./logitech_applet 
001/002     046D/C506   C-BF16-MSE      MX700 Optical Mouse
Error getting cruise control setting from device : error sending control
message: Broken pipe   Cruise Control / Smart Scroll: 8 (Unexpected result)
Unexpected cruise value : 8
   Result: 8
   P6  = 20
   P0  = 3d
   P4  = 8b
   P5  = 4d Channel 2    Battery: 5
   P8  = d7
   P9  = f
   PB0 = 1
   PB1 = ee Two channel   800cpi support   No Horizontal Roller   Vertical
   Roller   8 buttons 

I assume this is because of the MX700 firmware bugs.  Other than that it does
what it is supposed to.

Josh
