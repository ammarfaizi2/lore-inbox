Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUCSA0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263296AbUCSAWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:22:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50908 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263321AbUCRXu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:50:29 -0500
Date: Thu, 18 Mar 2004 23:50:24 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Greg KH <greg@kroah.com>, David Mosberger <davidm@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Matthew Wilcox <willy@debian.org>
Subject: [0/3] Make pci resources show up in iomem/ioport on ia64
Message-ID: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I decided to do one simple little thing -- make PCI device resources show
up in /proc/iomem and /proc/ioport on ia64 just like they do on i386.
Of course, I found two bugs in the process so we have three logically
separate patches that I shall be sending in reply to this message.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
