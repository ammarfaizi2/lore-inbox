Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWE2QaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWE2QaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 12:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWE2QaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 12:30:19 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:60584 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750907AbWE2QaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 12:30:18 -0400
Subject: Re: dev_printk output
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, Patrick Mansfield <patmans@us.ibm.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060529035725.GC23405@parisc-linux.org>
References: <20060511150015.GJ12272@parisc-linux.org>
	 <20060512170854.GA11215@us.ibm.com>
	 <20060513050059.GR12272@parisc-linux.org>
	 <20060518183652.GM1604@parisc-linux.org>
	 <20060518200957.GA29200@us.ibm.com>
	 <20060519201142.GB2826@parisc-linux.org> <20060519202847.GB8865@kroah.com>
	 <20060520045544.GD2826@parisc-linux.org> <20060520212135.GB24672@kroah.com>
	 <20060529035725.GC23405@parisc-linux.org>
Content-Type: text/plain
Date: Mon, 29 May 2006 11:30:05 -0500
Message-Id: <1148920205.3328.0.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 21:57 -0600, Matthew Wilcox wrote:
> Obviously, we could argue about the exact naming until the cows come
> home, 
> so let me say that I don't really care.  I just want something that
> looks like "scsi 0:0:0:0" rather than "sd 0:0:0:0" or " 0:0:0:0",
> depending on whether sd has been loaded or not.

If we follow the recommendations of the storage summit, we'll have to
trash the scsi bus type to get ata an upper level driver, so even this
will eventually no longer print what you want ...

James


