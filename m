Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVCDLPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVCDLPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVCDLNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:13:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8206 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262773AbVCDLGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:06:44 -0500
Date: Fri, 4 Mar 2005 11:06:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Diego Calleja <diegocg@gmail.com>
Cc: Dave Jones <davej@redhat.com>, akpm@osdl.org, torvalds@osdl.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304110633.C3932@flint.arm.linux.org.uk>
Mail-Followup-To: Diego Calleja <diegocg@gmail.com>,
	Dave Jones <davej@redhat.com>, akpm@osdl.org, torvalds@osdl.org,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050303052100.GA22952@redhat.com> <20050303214358.3c842a01.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050303214358.3c842a01.diegocg@gmail.com>; from diegocg@gmail.com on Thu, Mar 03, 2005 at 09:43:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 09:43:58PM +0100, Diego Calleja wrote:
> bugzilla.kernel.org is there but not many people look at it (which I
> understand, using bugzilla is painfull, altough basing all your
> development strategy around it _is_ rewarding, as happens in gnome/etc,
> where the release announcement includes a list bugzilla numbers which
> point to fixed bugs or "new feature" bugs in the case of new
> features).

As one of those who initially thought "great" about bugzilla for kernel
stuff, and then got rather annoyed with it, I think I can talk about
why bugzilla doesn't work for kernel developers.

* The most obvious problem is that it requires you to go to the website
  before you can do anything with a bug.
* Bug reporters appear to report a bug and run away - attempting to get
  more information from them sometimes resorts in silence until you
  threaten to close the bug, or do close the bug.
* Bug categories aren't explained well enough to allow users to determine
  the correct category.  Eg, PCMCIA network card - should that be
  networking or PCMCIA (where the bugzilla PCMCIA category is actually
  *only* the PCMCIA core and not any of the drivers.)

Overall, my experience with the kernel bugzilla has been rather
unproductive.  Most bugs which came in my direction weren't for things
I could resolve.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
