Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbULNAqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbULNAqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 19:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbULNAqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 19:46:12 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:64401 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261359AbULNAqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 19:46:07 -0500
Subject: Re: Suspend 2 merge: 50/51: Device mapper support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Alasdair G Kergon <agk@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dm-devel@redhat.com
In-Reply-To: <20041203201248.GU24229@agk.surrey.redhat.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101300802.5805.398.camel@desktop.cunninghams>
	 <20041125235829.GJ2909@elf.ucw.cz>
	 <1101427667.27250.175.camel@desktop.cunninghams>
	 <20041202204042.GD24233@agk.surrey.redhat.com>
	 <1102021461.13302.40.camel@desktop.cunninghams>
	 <20041202214932.GE24233@agk.surrey.redhat.com>
	 <1102025297.13302.51.camel@desktop.cunninghams>
	 <20041203174749.GF24233@agk.surrey.redhat.com>
	 <1102103827.22511.10.camel@desktop.cunninghams>
	 <20041203201248.GU24229@agk.surrey.redhat.com>
Content-Type: text/plain
Message-Id: <1102975253.15369.2.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 14 Dec 2004 11:47:35 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-12-04 at 07:12, Alasdair G Kergon wrote:
> [Quick commment only - travelling]
> 
> On Sat, Dec 04, 2004 at 06:57:07AM +1100, Nigel Cunningham wrote:
> > If, therefore, we we're using DM crypt to do our
> > I/O, it will help if we can either get it to allocate the memory it will
> > need prior to us preparing the metadata, or get from it an amount of
> > memory to include in the pool, given the maximum amount of I/O we intend
> > to have on the fly at once.
> 
> But where does dm-crypt use dm-io?  
> dm_get_pages is used by snapshots, mirrors etc.

Sorry for the slow reply. The module isn't just for dm-crypt support,
but for device mapper support in general. I'm seeking to not make
assumptions about what the configuration is, but simply make it support
LVM/md.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

