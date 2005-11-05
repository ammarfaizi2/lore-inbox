Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVKESNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVKESNj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVKESNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:13:38 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:58845 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932134AbVKESNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:13:37 -0500
Subject: Re: [GIT PATCH] SCSI updates for 2.6.14
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0511050942490.3316@g5.osdl.org>
References: <1131207491.3614.5.camel@mulgrave>
	 <Pine.LNX.4.64.0511050942490.3316@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 05 Nov 2005 12:13:27 -0600
Message-Id: <1131214408.3614.11.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-05 at 09:44 -0800, Linus Torvalds wrote:
> 
> On Sat, 5 Nov 2005, James Bottomley wrote:
> > 
> > This patch is available from:
> > 
> > master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-for-linus-2.6.git
> 
> No it's not.
> 
> 	master$ git-cat-file -t HEAD
> 
> gives
> 
> 	error: unable to find 39b7f1e25a412b0ef31e516cfc2fa4f40235f263
> 	fatal: git-cat-file HEAD: bad file
> 
> and the reason seems to be:
> 
> 	master$ ll objects/39/
> 
> 	ls: objects/39/: Permission denied
> 
> Hmmph.

Heh, they're all drwx--S--- 

I've had no end of strange trouble like this since I moved from my own
version of git to the one installed on hera.

I think I've found and changed all the directories and verified the
individual object permissions.  Could you try again?

Thanks,

James


