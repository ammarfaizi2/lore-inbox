Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752000AbWJ3Uhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWJ3Uhx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWJ3Uhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:37:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:37518 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752000AbWJ3Uhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:37:52 -0500
Date: Mon, 30 Oct 2006 12:36:52 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061030123652.d1574176.pj@sgi.com>
In-Reply-To: <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
References: <20061030103356.GA16833@in.ibm.com>
	<6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	<20061030031531.8c671815.pj@sgi.com>
	<6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
	<20061030042714.fa064218.pj@sgi.com>
	<6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes - let the sysadmin define the process groupings, and how those
> groupings get associated with resource control entities. The default
> should be that all the hierarchies are the same, since I think that's
> likely to be the common case.

Ah - I had thought earlier you were saying let the user define whether
or not (speaking metaphorically) their car had multiple gears in its
transmission, or just one gear.  That would have been kind of insane.

You meant we deliver a car with multiple gears, and its up to the user
when and if to ever shift.  That makes more sense.

In other words you are recommending delivering a system that internally
tracks separate hierarchies for each resource control entity, but where
the user can conveniently overlap some of these hierarchies and deal
with them as a single hierarchy.

What you are suggesting goes beyond the question of whether the kernel
has just and exactly and nevermore than one hierarchy, to suggest that
not only should the kernel support multiple hierarchies for different
resource control entities, but furthermore the kernel should make it
convenient for users to "bind" two or more of these hierarchies and
treat them as one.

Ok.  Sounds useful.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
