Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbULLDbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbULLDbu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 22:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbULLDbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 22:31:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20143 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261186AbULLDbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 22:31:48 -0500
Date: Sat, 11 Dec 2004 22:31:19 -0500
From: Dave Jones <davej@redhat.com>
To: "Camilo A. Reyes" <camilo@leamonde.no-ip.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe: QM_MODULES: Funtion not implemented on kernel 2.6.9
Message-ID: <20041212033119.GC1921@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Camilo A. Reyes" <camilo@leamonde.no-ip.org>,
	linux-kernel@vger.kernel.org
References: <20041211195133.GA2210@leamonde.no-ip.org> <41BBA98F.9080002@g-house.de> <20041212025217.GA16761@leamonde.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041212025217.GA16761@leamonde.no-ip.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2004 at 08:52:17PM -0600, Camilo A. Reyes wrote:

 > > this (and other interesting things) is described here:
 > > http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt
 > Wow! Now, thats the stuff! How come that's not included in the
 > kernel distro documentation, I'm sure lots of people that are new
 > to the kernel will have the same problem. Anyway thanks alot...

I've had a few people asking me to submit it, but I'm not
convinced it would be worthwhile.  Would people read it if
they had problems ?

make modules_install prints out a warning pointing them at it,
yet as this thread indicates, not everyone bothers to go there
and read it.  Maybe if it was in-tree things would be different,
but I'm not convinced. People want things to 'just work'
rather than have to read about how to make them work.

That said, if it was in-tree it would be easier for people
other than myself to update it as things change.
The current doc is a little out of date (last changed
about 6 months ago), so probably needs a little work
before its ready for submission.

Is there enough interest in this from people to justify
me putting any effort into it ?  If theres any value in
having this in tree, I'll submit the current version
to Andrew for -mm, and see if anyone dives in and starts
chopping/changing things.

If this does happen, it'd probably be worth eventually
replacing Documentation/Changes with it.

		Dave

