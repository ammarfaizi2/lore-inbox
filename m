Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUITPWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUITPWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 11:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUITPWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 11:22:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13514 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266646AbUITPWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 11:22:20 -0400
Date: Mon, 20 Sep 2004 10:58:43 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ingo Freund <Ingo.Freund@e-dict.net>
Cc: linux-kernel@vger.kernel.org, achim_leubner@adaptec.com
Subject: Re: three days running fine, then memory allocation errors
Message-ID: <20040920135843.GF3459@logos.cnet>
References: <20040920134835.GE3459@logos.cnet> <NEBBILBHKLDLOMLDGKGNMEKMCIAA.Ingo.Freund@e-dict.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NEBBILBHKLDLOMLDGKGNMEKMCIAA.Ingo.Freund@e-dict.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 05:17:17PM +0200, Ingo Freund wrote:
> > 
> > On Mon, Sep 20, 2004 at 04:58:02PM +0200, Ingo Freund wrote:
> > > Thank you for the answer.
> > > Well, I'll stop my requests to the drivers output immediatly.
> > > 
> > > The problem is, that I only get the errors on one machine.
> > > Others (with less memory) don't react this way. 
> > 
> > The others also have same gdth controllers? Are the disk configuration similar?
> > Numbers of disks, etc.
> 
> No not really, the others work with RAID1 (2 SATA disks) the concerned with 
> RAID1 + 5 (SCSI disks) on several disks and so on...

OK, so you see the problem is gdth specific... I've seen other users report
the same issue.

