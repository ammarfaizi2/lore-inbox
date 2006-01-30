Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWA3Hy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWA3Hy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 02:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWA3Hy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 02:54:28 -0500
Received: from ns.suse.de ([195.135.220.2]:23181 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750773AbWA3Hy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 02:54:27 -0500
Date: Mon, 30 Jan 2006 08:53:03 +0100
From: Stefan Seyfried <seife@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 00/23] [Suspend2] Freezer Upgrade Patches
Message-ID: <20060130075301.GA16895@suse.de>
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601270010.22702.rjw@sisk.pl> <200601271404.08680.nigel@suspend2.net> <200601271318.01985.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200601271318.01985.rjw@sisk.pl>
X-Operating-System: SUSE LINUX 10.0.42 (i586) Beta2, Kernel 2.6.16-rc1-git3-20060124230005-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 01:18:01PM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> On Friday, 27 January 2006 05:04, Nigel Cunningham wrote:

> > The simplest example would be:
> > 
> > dd if=/dev/hda of=/dev/null
> > echo disk > /sys/power/state
> 
> Well, I don't think it's a usual kind of workload. :-)

Compiling a kernel, having updatedb and mandb run in the background
and then trying to suspend while the compile still runs might do as well.

And this can happen, think of "battery-critical => suspend" setup.
This is exactly the case i do not like the suspend to fail, because there
might not be enough juice left to do a second try.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
