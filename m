Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVDXUn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVDXUn3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVDXUn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:43:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:28084 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262408AbVDXUn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:43:26 -0400
Message-ID: <426C04E3.9070508@suse.de>
Date: Sun, 24 Apr 2005 22:43:15 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: misc cleanups [4/4]
References: <200504232320.54477.rjw@sisk.pl> <200504232338.43297.rjw@sisk.pl> <20050423220757.GD1884@elf.ucw.cz> <426B7B97.4030009@suse.de> <20050424202230.GC30088@elf.ucw.cz>
In-Reply-To: <20050424202230.GC30088@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> That would not work, anyway. You want the messages from drivers,
> too... and drivers are not going to prepend "swsusp".

Yes it would. I do not need driver messages if the reason is "no swap
partition" or something like that ;-))

> Ultimately, cleaning up "suspend screen" so that it is not too scary
> for non-technical users might be nice... It means killing some debug
> messages from drivers, too.

I'd just sweep it under the bootsplash carpet. Then we have both:
possibility to debug and nice progressbar as long as everything works
fine :-)
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
