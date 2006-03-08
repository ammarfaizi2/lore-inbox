Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWCHXqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWCHXqL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWCHXqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:46:11 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:19602 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751524AbWCHXqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:46:10 -0500
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for
	2.6.16-rc5
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, gregkh@suse.de, bunk@stusta.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net,
       Neil Brown <neilb@cse.unsw.edu.au>, mmokrejs@ribosome.natur.cuni.cz,
       Nathan Scott <nathans@sgi.com>
In-Reply-To: <20060308152928.21afef81.akpm@osdl.org>
References: <20060306223545.GA20885@kroah.com>
	 <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de>
	 <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
	 <20060308152928.21afef81.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 15:45:51 -0800
Message-Id: <1141861551.8599.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 15:29 -0800, Andrew Morton wrote:
> - It would be nice to get Martin MOKREJ
>   <mmokrejs@ribosome.natur.cuni.cz>'s full 16GB recognised again.  Dave
>   Hansen is working on that. 

Martin, please step in here if your problem has come back...

After Martin applied my debugging patch, the problem went away.  Last I
heard, he was going to boot back into a kernel without my patch to see
if it stayed fixed.

My guess is that it is be a screwy BIOS that is causing the problem
intermittently.  Otherwise, I can't imagine how some printks could
affect the problem.  It's not like this is happening in code where there
are SMP races.

I also checked around the office a bit to see if anyone else was having
memory detection issues on large memory x86 machines.  No luck.  I'd put
this into the "unreproducible" bucket for now.

-- Dave

