Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266097AbUFJBwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUFJBwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 21:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266100AbUFJBwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 21:52:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52449 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266097AbUFJBwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 21:52:15 -0400
Date: Thu, 10 Jun 2004 02:52:13 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: linux-megaraid-devel@dell.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/scsi/megaraid.c: user/kernel pointer bugs
Message-ID: <20040610015213.GB12308@parcelfarce.linux.theplanet.co.uk>
References: <1086822637.32059.140.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086822637.32059.140.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 04:10:32PM -0700, Robert T. Johnson wrote:
> Since arg is a user pointer, so are uioc_mimd and uiocp, and hence umc is 
> a user pointer.  Thus reading umc->xferaddr requires dereferencing a user 
> pointer, which isn't safe.  Let me know if you have any questions or I've
> made an error.

ACK.
