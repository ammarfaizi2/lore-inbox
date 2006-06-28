Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWF1VT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWF1VT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWF1VT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:19:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33949 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751547AbWF1VT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:19:57 -0400
Date: Wed, 28 Jun 2006 23:19:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git broke suspend!
Message-ID: <20060628211937.GA30373@elf.ucw.cz>
References: <20060627181045.GA32115@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060627181045.GA32115@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-06-27 20:10:45, Jens Axboe wrote:
> Hi,
> 
> The git tree from yesterday and as of right now doesn't suspend on my
> laptop. It does it's regular thing, then hits:
> 
> [...]
> Stopping tasks:
> ===========================================================================================|
> eth1: Going into suspend...
> Class driver suspend failed for cpu0
> Could not power down device `×1x: error -22
                              ~~~~

Someone fails to initialize device name properly? :-(. Can you try
with minimum drivers?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
