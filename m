Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131414AbRCWUVv>; Fri, 23 Mar 2001 15:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbRCWUVn>; Fri, 23 Mar 2001 15:21:43 -0500
Received: from [193.120.224.170] ([193.120.224.170]:39574 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S131414AbRCWUVZ>;
	Fri, 23 Mar 2001 15:21:25 -0500
Date: Fri, 23 Mar 2001 20:18:48 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Guest section DW <dwguest@win.tue.nl>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Michael Peddemors <michael@linuxmagic.com>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010323182105.C6487@win.tue.nl>
Message-ID: <Pine.LNX.4.33.0103232013490.31380-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Guest section DW wrote:

> But yes, I am complaining because Linux by default is unreliable.

no, your distribution is unreliable by default.

> I strongly prefer a system that is reliable by default,
> and I'll leave it to others to run it in an unreliable mode.

currently, setting sensible user limits on my machines means i never
get a hosed machine due to OOM. These limits are easy to set via
pam_limits. (not perfect though, i think its session specific..)

granted, if the machine hasn't been setup with user limits, then linux
doesn't deal at all well with OOM, so this should be fixed. but it can
easily be argued that admin error in not configuring limits is the
main cause for OOM.

> Andries

regards,

--paulj

