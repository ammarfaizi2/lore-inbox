Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265891AbTIEUWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265892AbTIEUWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:22:36 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53777
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S265891AbTIEUWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:22:30 -0400
Date: Fri, 5 Sep 2003 13:22:32 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
Message-ID: <20030905202232.GD19041@matchmail.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195560000.1062788044@flay>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 11:54:04AM -0700, Martin J. Bligh wrote:
> > Backboost is gone so X really should be at -10 or even higher.
> 
> Wasn't that causing half the problems originally? Boosting X seemed
> to starve xmms et al. Or do the interactivity changes fix xmms
> somehow, but not X itself? Explicitly fiddling with task's priorities
> seems flawed to me.

Wasn't it the larger timeslices with lower nice values in stock and Con's
patches that made X with nice -10 a bad idea?
