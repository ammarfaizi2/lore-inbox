Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWJJSWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWJJSWO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWJJSV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:21:57 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:61103 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965008AbWJJSVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:21:36 -0400
Date: Tue, 10 Oct 2006 13:21:28 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Randy Dunlap <rdunlap@xenotime.net>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeremy Higdon <jeremy@sgi.com>, Pat Gefre <pfg@sgi.com>
Subject: Re: [PATCH 2/2] ioc4: Enable build on non-SN2
In-Reply-To: <20061010103915.f412d770.rdunlap@xenotime.net>
Message-ID: <20061010131916.D71367@pkunk.americas.sgi.com>
References: <20061010120928.V71367@pkunk.americas.sgi.com>
 <20061010103915.f412d770.rdunlap@xenotime.net>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Randy Dunlap wrote:

> Mostly curious:  did you observe that this is required?
> I always thought that Roman said that unknown config variables
> caused a rescan by kconfig.  IOW, I thought that it wouldn't
> be observable by a user.  Just wondering..

If it causes a rescan (I don't rightly know) it must have changed.
I caught a bit of flak for an incorrectly ordered config statement
once before, but that was a few years ago.

> The lines under ---help--- should be indented by 2 spaces (by
> convention) (and even though they were not when in the /sn/ subdir).

Thanks for catching that... I just blindly copied from one spot
to another.  I'll resend.

Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
