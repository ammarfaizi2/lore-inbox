Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVCVAf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVCVAf3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVCVASy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:18:54 -0500
Received: from static-162-83-93-166.fred.east.verizon.net ([162.83.93.166]:18058
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S262241AbVCVANd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:13:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16959.25374.535872.507486@ccs.covici.com>
Date: Mon, 21 Mar 2005 19:13:18 -0500
From: John covici <covici@ccs.covici.com>
To: Andrew Morton <akpm@osdl.org>
Cc: covici@ccs.covici.com, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dave Airlie <airlied@linux.ie>
Subject: Re: X not working with Radeon 9200 under 2.6.11
In-Reply-To: <20050321145301.3511c097.akpm@osdl.org>
References: <16937.54786.986183.491118@ccs.covici.com>
	<20050321145301.3511c097.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, no fb drivers, but someone did point me in the direction of the
x.org server and the crash went away using that server.  These are
unofficial Debian packages -- for more information look at
http://www.nixnuts.net/files .

on Monday 03/21/2005 Andrew Morton(akpm@osdl.org) wrote
 > John covici <covici@ccs.covici.com> wrote:
 > >
 > > Hi.  I Have a Radeon 9200c and ever since some time in the 2.6.9
 > > series, I cannot get X to start using this card.  It dies in such a
 > > way that there is no way to get the vga console out of that console
 > > and chvt from another terminal just hangs and xinit cannot be
 > > cancelled.
 > 
 > John, it would be useful if you could test 2.6.12-rc1-mm1, which has a few
 > fixes in this area.
 > 
 > Would it be correct to assume that you are not using either of the radeon
 > fbdev drivers?
 > 
 > And are you using the kernel's DRI drivers?
 > 
 > Thanks.
 > 
 > > This is the lspci for the agp card.
 > > 0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280
 > > [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
 > >      Subsystem: PC Partner Limited: Unknown device 7c26
 > >      Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
 > >      Memory at e8000000 (32-bit, prefetchable) [size=128M]
 > >      I/O ports at e000 [size=256]
 > >      Memory at fbe00000 (32-bit, non-prefetchable) [size=64K]
 > >      Expansion ROM at fbd00000 [disabled] [size=128K]
 > >      Capabilities: [58] AGP version 3.0
 > >      Capabilities: [50] Power Management version 2
 > > 
 > > 0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon
 > > 9200 SE] (Secondary) (rev 01)
 > >      Subsystem: PC Partner Limited: Unknown device 7c27
 > >      Flags: bus master, 66MHz, medium devsel, latency 64
 > >      Memory at f0000000 (32-bit, prefetchable) [size=128M]
 > >      Memory at fbf00000 (32-bit, non-prefetchable) [size=64K]
 > >      Capabilities: [50] Power Management version 2
 > > 
 > > Any assistance would be appreciated.
 > > 
 > > -- 
 > > Your life is like a penny -- how are you going to spend it?
 > > 
 > >          John Covici
 > >          covici@ccs.covici.com
 > > -
 > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > > the body of a message to majordomo@vger.kernel.org
 > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > > Please read the FAQ at  http://www.tux.org/lkml/

-- 
Your life is like a penny -- how are you going to spend it?

         John Covici
         covici@ccs.covici.com
