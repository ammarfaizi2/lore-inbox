Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266580AbUGKMTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266580AbUGKMTx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 08:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266579AbUGKMTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 08:19:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11945 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266577AbUGKMTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 08:19:51 -0400
Date: Sun, 11 Jul 2004 13:19:50 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, davidm@hpl.hp.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com, torvalds@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
Message-ID: <20040711121950.GU5889@parcelfarce.linux.theplanet.co.uk>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com> <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com> <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com> <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com> <20040711030225.11fb61e7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711030225.11fb61e7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 03:02:25AM -0700, Andrew Morton wrote:
> Apropos of nothing much, CONFIG_X86 would be preferreed here, but x86_64
> defines that too.

IMO, x86-64 should stop defining CONFIG_X86.  It's far more common
to say "X86 && !X86_64" than it is to say X86.  How about defining
CONFIG_X86_COMMON and migrating usage of X86 to X86_COMMON?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
