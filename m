Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbULBWMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbULBWMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 17:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbULBWMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 17:12:21 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:64202 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261780AbULBWMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 17:12:17 -0500
Subject: Re: Suspend 2 merge: 50/51: Device mapper support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Alasdair G Kergon <agk@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041202214932.GE24233@agk.surrey.redhat.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101300802.5805.398.camel@desktop.cunninghams>
	 <20041125235829.GJ2909@elf.ucw.cz>
	 <1101427667.27250.175.camel@desktop.cunninghams>
	 <20041202204042.GD24233@agk.surrey.redhat.com>
	 <1102021461.13302.40.camel@desktop.cunninghams>
	 <20041202214932.GE24233@agk.surrey.redhat.com>
Content-Type: text/plain
Message-Id: <1102025297.13302.51.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 03 Dec 2004 09:08:18 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right.

My mistake. The code has been improved and I haven't reverted some of
the changes in drivers/md to match. I'll do that and make the two
exports that are needed (dm_io_get and dm_io_put) into an
include/linux/dm.h.

Regards,

Nigel

On Fri, 2004-12-03 at 08:49, Alasdair G Kergon wrote:
> On Fri, Dec 03, 2004 at 08:04:21AM +1100, Nigel Cunningham wrote:
> > It's not internals that need to be exposed.
>  
> Then why move an internal dm-io structure into a header file and 
>   #include "../../drivers/md/dm-io.h"
> from another part of the tree?
> 
> Alasdair
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

