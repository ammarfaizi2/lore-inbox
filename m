Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWDDWOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWDDWOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWDDWOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:14:25 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:49359
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750786AbWDDWOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:14:24 -0400
Date: Tue, 4 Apr 2006 15:13:18 -0700
From: Greg KH <greg@kroah.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jody McIntyre <scjody@modernduck.com>,
       linux1394-devel@lists.sourceforge.net, stable@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] [PATCH] sbp2: fix spinlock recursion
Message-ID: <20060404221318.GH6150@kroah.com>
References: <tkrat.11bf8809a766b402@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.11bf8809a766b402@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 09:11:41PM +0200, Stefan Richter wrote:
> sbp2util_mark_command_completed takes a lock which was already taken by
> sbp2scsi_complete_all_commands.  This is a regression in Linux 2.6.15.
> Reported by Kristian Harms at
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=187394
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

queued to -stable, thanks.

greg k-h

