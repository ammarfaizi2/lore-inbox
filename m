Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbUCMTXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 14:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263175AbUCMTXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 14:23:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48854 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263172AbUCMTXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 14:23:04 -0500
Date: Sat, 13 Mar 2004 14:25:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Matthew Galgoci <mgalgoci@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atkbd shaddup
Message-ID: <20040313132505.GB3352@openzaurus.ucw.cz>
References: <Pine.LNX.4.44.0403121228100.28918-100000@lacrosse.corp.redhat.com> <20040312183738.GA3233@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312183738.GA3233@thunk.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I can't be the only person to be annoyed by the "too many keys
> > pressed" error message that often gets spewed across the console
> > when I am typing fast. This patch turns that error message (and
> > others) into info message. Also, one debug message was turned into
> > info, and a couple of warnings were turned into info where I thought
> > it made sense.
> 
> I'd go even further.  Do we need to print the "too many keys pressed"
> message at *all*?  Why would anyone care?

You are typing too fast and key gets lost. You'll either think
that its your fault or that microswitch is failing. With
the message you know keyboard is miss-designed.
KERN_INFO seems fine...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

