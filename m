Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUBXO7B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 09:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbUBXO7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 09:59:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44465 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262253AbUBXO67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 09:58:59 -0500
Date: Tue, 24 Feb 2004 14:58:56 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH][BUGFIX] : megaraid patch for 2.10.1 (irq disable bug fix)
Message-ID: <20040224145856.GL25779@parcelfarce.linux.theplanet.co.uk>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3D9@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC3D9@exa-atlanta.se.lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 09:47:06AM -0500, Mukker, Atul wrote:
> > > Could we have a later version than 2.00.3 in 2.6 please?
> We are in process of releasing a unified driver, which will natively support
> the 2.4.x and 2.6.x kernels. 

In the past, this has generally been a very bad idea.  It's led to some
excessively ugly drivers (see aic7xxx for one) and generally doesn't work
terribly well.  If you insist on going down this road, could you at least
make sure it's written to the newest 2.6 APIs and every other supported
kernel version emulates the 2.6 APIs?  The awful "kernel neutral API"s
used in some drivers really suck.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
