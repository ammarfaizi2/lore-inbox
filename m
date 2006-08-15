Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWHOWmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWHOWmv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 18:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWHOWmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 18:42:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11984 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750762AbWHOWmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 18:42:51 -0400
Date: Wed, 16 Aug 2006 00:42:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Robert Love <rlove@rlove.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       hdaps-devel@lists.sourceforge.net, Jean Delvare <khali@linux-fr.org>
Subject: Re: [-mm patch] hdaps: Add explicit hardware configuration functions - fix
Message-ID: <20060815224230.GC8938@elf.ucw.cz>
References: <41840b750608151526r19748630y75118a2f5032ca6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608151526r19748630y75118a2f5032ca6@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-08-16 01:26:07, Shem Multinymous wrote:
> Fixes two things about hdaps_check_ec() in the hdaps driver:
> 1. Remove the __init, it may be called well after module init, during 
> resume.
> 2. Remove an unused parameter.
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>

Looks okay to me.

Signed-off-by: Pavel Machek <pavel@suse.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
