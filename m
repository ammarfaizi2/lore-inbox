Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUD1Uq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUD1Uq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUD1UC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:02:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52911 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261421AbUD1TRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:17:12 -0400
Date: Tue, 27 Apr 2004 20:52:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040427185230.GR2595@openzaurus.ucw.cz>
References: <408DC0E0.7090500@gmx.net> <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > LinuxAnt offers binary only modules without any sources. To circumvent our
> > MODULE_LICENSE checks LinuxAnt has inserted a "\0" into their declaration:
> > 
> > MODULE_LICENSE("GPL\0for files in the \"GPL\" directory; for others, only
> > LICENSE file applies");
> 
> Hey, that is interesting in itself, since playing the above kinds of games
> makes it pretty clear to everybody that any infringement was done
> wilfully. They should be talking to their lawyers about things like that.

Even better they should be talking to our layers.

Are they trying to get access to GPL-only symbols? 
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

