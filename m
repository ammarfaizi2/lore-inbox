Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUBHQkN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUBHQkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:40:13 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:13725 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263832AbUBHQkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:40:03 -0500
Subject: Re: [BK PATCH] bug fixes for scsi for linux-2.6.3-rc1
From: James Bottomley <James.Bottomley@steeleye.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040208161911.GF24334@parcelfarce.linux.theplanet.co.uk>
References: <1076256895.2055.6.camel@mulgrave> 
	<20040208161911.GF24334@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Feb 2004 11:39:51 -0500
Message-Id: <1076258392.2055.9.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-08 at 11:19, Matthew Wilcox wrote:
> Wasn't the mptscsih_exit problem already fixed by:
> 
> http://linux.bkbits.net:8080/linux-2.5/patch@1.1500.2.166?nav=index.html|ChangeSet@-3d|cset@1.1500.2.166
> 
> (went in via akpm 48 hours ago)

Hmm, missed that.

That would make the safest course of action to leave that in, and redo
the true fix after 2.6.3 is released.

Hang on, I'll redo the scsi-for-linus-2.6 tree.

James


