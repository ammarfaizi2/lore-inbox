Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVBFUnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVBFUnD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 15:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVBFUnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 15:43:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:26286 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261313AbVBFUm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 15:42:59 -0500
Date: Sun, 6 Feb 2005 12:42:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: nathans@sgi.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page
 cache pages.
Message-Id: <20050206124236.264f0cd4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0502061932270.21938@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
	<20050202143422.41c29202.akpm@osdl.org>
	<1107427057.9010.18.camel@imp.csi.cam.ac.uk>
	<20050203024755.1792b6c0.akpm@osdl.org>
	<Pine.LNX.4.60.0502061932270.21938@hermes-1.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> On Thu, 3 Feb 2005, Andrew Morton wrote:
> > I did a patch which switched loop to use the file_operations.read/write
> > about a year ago.  Forget what happened to it.  It always seemed the right
> > thing to do..
> 
> How did you implement the write?

It was Urban, actually.  Memory fails me.

http://marc.theaimsgroup.com/?l=linux-fsdevel&m=102133217310200&w=2

It won't work properly for crypto transformations - iirc we decided it
would need to perform a copy.
