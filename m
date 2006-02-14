Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbWBNIVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbWBNIVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030518AbWBNIVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:21:40 -0500
Received: from host-a-002.milc.com.pl ([213.17.132.2]:17579 "EHLO milc.com.pl")
	by vger.kernel.org with ESMTP id S1030516AbWBNIVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:21:39 -0500
Date: Tue, 14 Feb 2006 09:21:36 +0100
From: Yoss <bartek@milc.com.pl>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4.33-pre1?
Message-ID: <20060214082136.GA9993@milc.com.pl>
References: <20060213214651.GA27844@milc.com.pl> <20060214000529.GJ11380@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060214000529.GJ11380@w.ods.org>
User-Agent: Mutt/1.3.28i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.4 (milc.com.pl [127.0.0.1]); Tue, 14 Feb 2006 09:21:36 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 01:05:30AM +0100, Willy Tarreau wrote:
> You don't have to worry. Simply check /proc/slabinfo, you'll see plenty
> of memory used by dentry_cache and inode_cache and that's expected. This
> memory will be reclaimed when needed (for instance by calls to malloc()).

I downgraded hernel to 2.4.33 last night. So there is no slabinfo from
that problem now. But thank you for reply. Why is this memory not 
showed somewhere in top or free?

> If you don't believe me, simply allocate 1 GB in a process, then free it.

If that what you said is rigth, day after tomorow I'll have the same
situation - only thing I have changed is kernel. So we'll see. :)

-- 
Bart³omiej Butyn aka Yoss
Nie ma tego z³ego co by na gorsze nie wysz³o.
