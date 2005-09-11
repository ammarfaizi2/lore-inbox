Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVIKJ3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVIKJ3R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 05:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVIKJ3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 05:29:17 -0400
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:40636 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964838AbVIKJ3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 05:29:17 -0400
Message-ID: <4323F8E9.3010506@eyal.emu.id.au>
Date: Sun, 11 Sep 2005 19:29:13 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennert Buytenhek <buytenh@wantstofly.org>
CC: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: read-from-all-disks support for RAID1?
References: <20050910123902.GA9461@xi.wantstofly.org>
In-Reply-To: <20050910123902.GA9461@xi.wantstofly.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek wrote:
> (please CC on replies)
> 
> Hi!
> 
> I recently had a case where one disk in a two-disk RAID1 array went
> subtly bad, effectively refusing to write to certain sectors without
> reporting an error.  Basically, parts of the disk went undetectably
> read-only, causing file system corruption that wouldn't go away after
> fsck, and all kinds of other fun.
> 
> Would it be hard/wise to add an option for RAID1 mode to read from all
> devices on a read, and report an error to syslog or simply return an
> I/O error if there is a mismatch?  (Or use majority voting and tell
> people to use 3-disk RAID1 arrays from now on ;-)
> 
> 
> thanks,
> Lennert

Would a two-disk raid-5 not do just what you want?

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
