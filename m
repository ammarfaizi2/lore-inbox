Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVCDKzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVCDKzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVCDKys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:54:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3856 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262717AbVCDKww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:52:52 -0500
Date: Fri, 4 Mar 2005 10:52:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, torvalds@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304105247.B3932@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Dave Jones <davej@redhat.com>, torvalds@osdl.org, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050302203812.092f80a0.akpm@osdl.org>; from akpm@osdl.org on Wed, Mar 02, 2005 at 08:38:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 08:38:12PM -0800, Andrew Morton wrote:
> Grump.  Have all these regressions received the appropriate level of
> visibility on this mailing list?

Looking at the http://l4x.org/k/ site, it appears that all -mm versions
have broken ARM support with the defconfig, while Linus kernels at least
build fine. I've no idea why though.

I haven't had any reports of breakage, and I don't think I've missed
any heads up on something which needs to be fixed up, except maybe the
4 level page table stuff.  (TBH I don't think many ARM people look at
-mm, but it is worrying that something which may be merged into Linus'
tree from -mm may have the unexpected consequence of breaking something
which used to work.)

Unfortunately, http://l4x.org/k/ doesn't save any build logs for
investigation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
