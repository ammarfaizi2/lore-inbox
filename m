Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWEAQHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWEAQHn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 12:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWEAQHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 12:07:43 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:41194 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932141AbWEAQHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 12:07:42 -0400
Date: Mon, 1 May 2006 18:07:35 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: Andrew Morton <akpm@osdl.org>
Cc: neilb@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages.
Message-ID: <20060501160735.GB6222@uio.no>
References: <20060420160549.7637.patches@notabene> <1060420062955.7727@suse.de> <20060420003839.1a41c36f.akpm@osdl.org> <20060426204809.GA15462@uio.no> <20060426135809.10a37ec3.akpm@osdl.org> <20060426212659.GA15770@uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060426212659.GA15770@uio.no>
X-Operating-System: Linux 2.6.16.11 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
X-Spam-Score: -0.0 (/)
X-Spam-Report: Status=No hits=-0.0 required=5.0 tests=NO_RELAYS version=3.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 11:26:59PM +0200, Steinar H. Gunderson wrote:
>> It had a silly bug.  Fixed version:
> Thanks, that boots. Of course, since I've only seen the RAID-5 hang bug
> once ever, I've got no idea whether it actually fixes it, but I guess that if
> the machine is stable for a week or so, it actually fixes my kswapd problem
> too :-)

pannekake:~> uptime
 18:07:08 up 4 days, 18:51,  1 user,  load average: 0.28, 0.18, 0.11

Wow. I'm starting to believe this patch actually helped... :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
