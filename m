Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTDWRZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbTDWRZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:25:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:59294 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264146AbTDWRZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:25:28 -0400
Date: Wed, 23 Apr 2003 10:26:38 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Pat Suwalski <pat@suwalski.net>, Matthias Schniedermeyer <ms@citd.de>
cc: Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <1527920000.1051118798@flay>
In-Reply-To: <3EA6947D.9080106@suwalski.net>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I can only guess why. My buest guess is that not all
>> sound-configurations are the same, on some systems the "defaults" could
>> much to loud. (e.g. waking the neigbours when you restart you computer
>> at night)
> 
> This is certainly the case. When I was packaging OSS for Xandros, our initial default was 50 percent. We eventualyl made it about 30, because even that was too loud on a laptop we were testing. There was little coherance between the various soundcards.
> 
> Waking the neighbors is the smallest problem. Blowing a speaker or makign the user deaf if quite another.
> 
> Yes, it's a distro problem. My Gentoo was build "-alsa" and so the alsa-sound init script does not 'go'. A simple rebuild will solve the problem.

I agree it's a disto problem to save and restore.

But I fail to understand how the distro can magically set a sensible 
default, and yet we're unable to do so inside the kernel ? Setting it
to something like 10 (or other very quiet setting) would seem reasonable.
Then at least the poor user would have a clue what the problem was.

As to "There was little coherance between the various soundcards", yes
this probably needs to be a per-soundcard setting for sensible defaults.
I presume this is what the distros do?

Defaulting to silence seems user-malevolent ... 

M.

