Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbTCTPsp>; Thu, 20 Mar 2003 10:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbTCTPsp>; Thu, 20 Mar 2003 10:48:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24027 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261483AbTCTPso>;
	Thu, 20 Mar 2003 10:48:44 -0500
Date: Thu, 20 Mar 2003 15:59:43 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       jes@trained-monkey.org
Subject: Re: [PATCH] Fixup warning for acenic
Message-ID: <20030320155943.GC14520@parcelfarce.linux.theplanet.co.uk>
References: <20030320151754.GB14520@parcelfarce.linux.theplanet.co.uk> <7000000.1048175453@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7000000.1048175453@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 07:50:55AM -0800, Martin J. Bligh wrote:
> > Please don't delete this table.  At some point when Jes gets his head
> > out of the "must support Linux 1.2" space, this table will be used and
> > then this driver will support hotplugging.
> 
> Fair enough ... but can we wrap it in CONFIG_SOMETHING? or #if 0 ?

If you must, you could wrap it in MODULE.  I don't see the value in
removing every single warning from the kernel build.  If you're intent on
chasing all these pointless things, try installing gcc 3.3 and compiling
a kernel with that.  It'll pump out more warnings than you can shake
a pointy stick at.  Or turn on -W with gcc 2.96 -- it has much the
same effect.  I made an effort to remove some of the -W warnings from
the header files a while ago so I could compile individual files with
-W as I find it tends to point out some mistakes I often make.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
