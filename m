Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbULCUQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbULCUQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbULCUQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:16:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64479 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262492AbULCUNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:13:34 -0500
Date: Fri, 3 Dec 2004 20:12:48 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Alasdair G Kergon <agk@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dm-devel@redhat.com
Subject: Re: Suspend 2 merge: 50/51: Device mapper support.
Message-ID: <20041203201248.GU24229@agk.surrey.redhat.com>
Mail-Followup-To: Nigel Cunningham <ncunningham@linuxmail.org>,
	Alasdair G Kergon <agk@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dm-devel@redhat.com
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300802.5805.398.camel@desktop.cunninghams> <20041125235829.GJ2909@elf.ucw.cz> <1101427667.27250.175.camel@desktop.cunninghams> <20041202204042.GD24233@agk.surrey.redhat.com> <1102021461.13302.40.camel@desktop.cunninghams> <20041202214932.GE24233@agk.surrey.redhat.com> <1102025297.13302.51.camel@desktop.cunninghams> <20041203174749.GF24233@agk.surrey.redhat.com> <1102103827.22511.10.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102103827.22511.10.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Quick commment only - travelling]

On Sat, Dec 04, 2004 at 06:57:07AM +1100, Nigel Cunningham wrote:
> If, therefore, we we're using DM crypt to do our
> I/O, it will help if we can either get it to allocate the memory it will
> need prior to us preparing the metadata, or get from it an amount of
> memory to include in the pool, given the maximum amount of I/O we intend
> to have on the fly at once.

But where does dm-crypt use dm-io?  
dm_get_pages is used by snapshots, mirrors etc.

Alasdair
-- 
agk@redhat.com
