Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267609AbUBTAsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267622AbUBTAqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:46:14 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:19710 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S267609AbUBTAhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:37:05 -0500
Date: Thu, 19 Feb 2004 16:34:55 -0800
From: Tim Hockin <thockin@sun.com>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: sysconf - exposing constants to userspace
Message-ID: <20040220003455.GI9155@sun.com>
Reply-To: thockin@sun.com
References: <20040219204820.GC9155@sun.com> <200402191630.47047.jeffpc@optonline.net> <20040220002034.GC5590@mail.shareable.org> <200402191929.54604.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402191929.54604.jeffpc@optonline.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 07:29:45PM -0500, Jeff Sipek wrote:
> If I understand the original post correctly, the numbers that we don't make 
> available to userspace are compile time constants. For example, since I can't 
> think of anything better, NR_CPUS. It is set during the config process, but 
> one cannot read the number from userspace while running that kernel. I know 
> that there are better examples, but I just can't think of any at the moment.
> 
> If I missed the point of the original post, please ignore me.

No, you got it.  BUt I was specifically thinking of POSIX sysconf stuff,
like NGROUPS_MAX.  See <linux/limits.h>.

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
