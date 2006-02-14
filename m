Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030509AbWBNIWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbWBNIWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbWBNIWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:22:52 -0500
Received: from host-a-002.milc.com.pl ([213.17.132.2]:19627 "EHLO milc.com.pl")
	by vger.kernel.org with ESMTP id S1030509AbWBNIWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:22:52 -0500
Date: Tue, 14 Feb 2006 09:22:46 +0100
From: Yoss <bartek@milc.com.pl>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4.33-pre1?
Message-ID: <20060214082246.GB9993@milc.com.pl>
References: <20060213214651.GA27844@milc.com.pl> <20060214000529.GJ11380@w.ods.org> <43F12597.2000006@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43F12597.2000006@drugphish.ch>
User-Agent: Mutt/1.3.28i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.4 (milc.com.pl [127.0.0.1]); Tue, 14 Feb 2006 09:22:47 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 01:34:31AM +0100, Roberto Nibali wrote:
> >You don't have to worry. Simply check /proc/slabinfo, you'll see plenty
> >of memory used by dentry_cache and inode_cache and that's expected. This
> 
> Well, 300M dentry and inode is quite a lot for a system that has been up 
> at most for 6 days.

It has 3 days uptime. But I wrote in prevoius mail, I rebooted it last
night to downgrade kernel.

-- 
Bart³omiej Butyn aka Yoss
Nie ma tego z³ego co by na gorsze nie wysz³o.
