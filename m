Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUBSTyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbUBSTux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:50:53 -0500
Received: from mail.tmr.com ([216.238.38.203]:2311 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267512AbUBSTsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:48:43 -0500
Date: Thu, 19 Feb 2004 14:47:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Bas Mevissen <ml@basmevissen.nl>
cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Dittmer <j.dittmer@portrix.net>,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
In-Reply-To: <4034819E.7030004@basmevissen.nl>
Message-ID: <Pine.LNX.3.96.1040219144500.23912D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Bas Mevissen wrote:

> Bill Davidsen wrote:
> > 
> >> It looks like this only appeared once. The FS looks fine now. So I guess
> >>  I won't be able to reproduce it. Let's just go to 2.6.[23] and see if
> >> it happens again.
> > 
> > Did this go away on reboot, or did you have to fix it? If it went away
> > on reboot, it could be that the copy of the inode in memory was borked.
> > 
> 
> I really had to fix it. But, it never appeared again until now. So maybe 
> this was just caused by some crash while experimenting with swsusp2.

Another WAG bites the dust, but at least it's clear that you had damage to
the metadata on the media. Hopefully that would be useful if it comes back
to visit again.

Glad you COULD fix it!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

