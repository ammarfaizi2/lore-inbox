Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTLUT6A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbTLUT5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:57:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:30175 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263985AbTLUT5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:57:43 -0500
Date: Sun, 21 Dec 2003 11:56:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Karim Yaghmour <karim@opersys.com>
cc: yodaiken@fsmlabs.com, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Updating real-time and nanokernel maintainersy
In-Reply-To: <3FE5F2E6.8030002@opersys.com>
Message-ID: <Pine.LNX.4.58.0312211145490.13039@home.osdl.org>
References: <3FE234E4.8020500@opersys.com> <Pine.LNX.4.58.0312181821270.19491@montezuma.fsmlabs.com>
 <3FE23966.7060001@opersys.com> <Pine.LNX.4.58.0312181836360.19491@montezuma.fsmlabs.com>
 <3FE23CD1.4080802@opersys.com> <3FE23E3F.2000801@cyberone.com.au>
 <3FE2424B.70901@opersys.com> <20031219094122.GA23469@wohnheim.fh-wedel.de>
 <20031221082736.GA11795@hq.fsmlabs.com> <3FE5F2E6.8030002@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Dec 2003, Karim Yaghmour wrote:
> 
> If there is, then it should definitely be taken out. First, as Linus
> has stated recently (and as has been the policy for a while), the
> kernel should avoid having any patented code

That's not true.

The kernel should have no patented code THAT DOESN'T HAVE A LICENSE.

There are several cases where this came up: RCU is one obvious one, but 
there were also issues with Intel's initial submissions of some of the 
networking drivers where they didn't want to originally release under the 
GPL because of worrying about patents they owned.

The email you quote expressly says "unless you can get the patent holder 
to grant a license". And the RTLinux patents were licensed to GPL'd 
projects. See the RTLinux "open patent license".

I don't understand why people continually complain about the RTLinux
patents. I bet it's because Victor has all the easy charm of Larry McVoy,
but I don't see why people still continue to spread obvious
mis-information about the situation.

It's doubly discgusting with some of the people who were trying to spread 
all the FUD and mis-information were doing so because they were themselves 
doing a non-GPL microkernel, and they complained about how the patents 
were somehow against the GPL and wanted to get community support by trying 
to make out the situation to be somehow different from what it was.

I'm not a supporter of software patents, but while I dislike them, I don't 
dislike them _nearly_ as much as I dislike dishonest people.

		Linus
