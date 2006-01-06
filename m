Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752472AbWAFQq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbWAFQq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbWAFQq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:46:28 -0500
Received: from xenotime.net ([66.160.160.81]:37523 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752472AbWAFQq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:46:27 -0500
Date: Fri, 6 Jan 2006 08:46:19 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] suspend: update documentation
In-Reply-To: <20060106110922.GC9219@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.58.0601060843190.11324@shark.he.net>
References: <20060106110922.GC9219@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Pavel Machek wrote:

> This updates documentation for suspend-to-disk and RAM. In particular
> modular disk drivers trap is documented.
>
> Signed-off-by: Pavel Machek <pavel@suse.cz>
>
> --- a/Documentation/power/swsusp.txt
> +++ b/Documentation/power/swsusp.txt
> @@ -27,13 +27,11 @@ echo shutdown > /sys/power/disk; echo di
> +. If you have SATA disks, you'll need recent kernels with SATA suspend
> +support. For suspend and resume to work, make sure your disk drivers
> +are built into kernel -- not modules. [There's way to make
> +suspend/resume with modular disk drivers, see FAQ, but you should
> +better not do that.]

(drop "better", or say "but you probably shouldn't do that.")

What recent kernels have SATA suspend/resume support?
Not from kernel.org AFAIK.

-- 
~Randy
