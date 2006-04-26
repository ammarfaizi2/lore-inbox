Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWDZV1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWDZV1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWDZV1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:27:08 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:53143 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S964880AbWDZV1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:27:06 -0400
Date: Wed, 26 Apr 2006 23:26:59 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: Andrew Morton <akpm@osdl.org>
Cc: neilb@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages.
Message-ID: <20060426212659.GA15770@uio.no>
References: <20060420160549.7637.patches@notabene> <1060420062955.7727@suse.de> <20060420003839.1a41c36f.akpm@osdl.org> <20060426204809.GA15462@uio.no> <20060426135809.10a37ec3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060426135809.10a37ec3.akpm@osdl.org>
X-Operating-System: Linux 2.6.14.3 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 01:58:09PM -0700, Andrew Morton wrote:
> It had a silly bug.  Fixed version:

Thanks, that boots. Of course, since I've only seen the RAID-5 hang bug
once ever, I've got no idea whether it actually fixes it, but I guess that if
the machine is stable for a week or so, it actually fixes my kswapd problem
too :-)

Oddly enough, I've seen other oopses on 2.6 with amd64 and software RAID
(http://blog.madduck.net/geek/2006.01.07-kernel-oops.html) involving
invalidate_mapping_page somehow. I wonder if there's a trend here somewhere
or if I'm just into conspiracy theories...

/* Steinar */
-- 
Homepage: http://www.sesse.net/
