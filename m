Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVCKWTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVCKWTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVCKWTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:19:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34210 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261773AbVCKWSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:18:47 -0500
Date: Fri, 11 Mar 2005 17:18:39 -0500
From: Dave Jones <davej@redhat.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Paul Mackerras <paulus@samba.org>, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
Message-ID: <20050311221838.GG4185@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Paul Mackerras <paulus@samba.org>, torvalds@osdl.org,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <1110579068l.8904l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110579068l.8904l.0l@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 10:11:08PM +0000, J.A. Magallon wrote:
 > 
 > On 03.11, Paul Mackerras wrote:
 > > Linus,
 > > 
 > ...
 > > 
 > > Oh, and by the way, I have 3D working relatively well on my G5 with a
 > > 64-bit kernel (and 32-bit X server and clients), which is why I care
 > > about AGP 3.0 support. :)
 > > 
 > 
 > I think it is not a G5 only problem. I have a x8 card, a x8 slot, but
 > agpgart keeps saying this:
 > 
 > Mar 11 23:00:28 werewolf dm: Display manager startup succeeded
 > Mar 11 23:00:29 werewolf kernel: agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
 > Mar 11 23:00:29 werewolf kernel: agpgart: reserved bits set in mode 0xa. Fixed.
 > Mar 11 23:00:29 werewolf kernel: agpgart: X passes broken AGP2 flags (2) in AGP3 mode. Fixed.
 > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
 > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
 > Mar 11 23:00:29 werewolf kernel: agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
 > Mar 11 23:00:29 werewolf kernel: agpgart: reserved bits set in mode 0xa. Fixed.
 > Mar 11 23:00:29 werewolf kernel: agpgart: X passes broken AGP2 flags (2) in AGP3 mode. Fixed.
 > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
 > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
 > 
 > The nvidia driver (brand new 1.0-7167, now works with stock -mm) tells me
 > it is in x8 mode, but i suspect it lies....
 > 
 > Will try your patch right now.

Testing latest -bk would be useful.
It has Paul's patch, and a few others.

		Dave

