Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932713AbVLBBkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbVLBBkd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbVLBBkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:40:33 -0500
Received: from xenotime.net ([66.160.160.81]:40635 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932713AbVLBBkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:40:32 -0500
Date: Thu, 1 Dec 2005 17:40:31 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: from-linux-kernel@i-love.sakura.ne.jp
cc: linux-kernel@vger.kernel.org
Subject: Re: Wrong permission for kernel source tar ball !?
In-Reply-To: <200512020134.jB21YQpJ046558@www262.sakura.ne.jp>
Message-ID: <Pine.LNX.4.58.0512011739280.10256@shark.he.net>
References: <200512020134.jB21YQpJ046558@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005 from-linux-kernel@i-love.sakura.ne.jp wrote:

> Hello,
>
> "find -type f -perm 6" shows
> extracted regular files are writable to everybody
> for linux-2.6.14.tar.bz2 and later.
>
> Something happened?

Yes, you unzipped the tarball as root.  Don't do that.
You should unzip & build kernels as a regular user
and only become root to do install functions.

-- 
~Randy
