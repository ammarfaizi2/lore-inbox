Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWGGReW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWGGReW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWGGReW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:34:22 -0400
Received: from khc.piap.pl ([195.187.100.11]:31638 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932179AbWGGReW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:34:22 -0400
To: ric@emc.com
Cc: Tomasz Torcz <zdzichu@irc.pl>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	<20060701170729.GB8763@irc.pl>
	<20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	<20060701181702.GC8763@irc.pl> <44AD286F.3030507@emc.com>
	<m3ejwyiryr.fsf@defiant.localdomain> <44AD4807.6090704@emc.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 07 Jul 2006 19:34:17 +0200
In-Reply-To: <44AD4807.6090704@emc.com> (Ric Wheeler's message of "Thu, 06 Jul 2006 13:27:35 -0400")
Message-ID: <m3hd1t8gkm.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ric Wheeler <ric@emc.com> writes:

> The key is to keep the signature/checksum with the file - tripwire and
> backup programs could do this (and even store it their own extended
> attribute), but I think that it is more generically useful than that.

I can't still see a sane way to do it. Yes, there might be some way
for very special purposes but there is no solution for general use.

> If you care enough about the data integrity of a file, having this
> kind of optional validation on any open would be very useful.

Given we can only do that for very specific purposes, I think the
userspace is better suited.
-- 
Krzysztof Halasa
