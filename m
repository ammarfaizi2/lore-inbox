Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWAZLRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWAZLRa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 06:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWAZLRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 06:17:30 -0500
Received: from ns.suse.de ([195.135.220.2]:5334 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932298AbWAZLR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 06:17:29 -0500
Message-ID: <43D8AFC6.4010804@suse.de>
Date: Thu, 26 Jan 2006 12:17:26 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP alternatives
References: <43D648CC.4090101@suse.de> <20060126102250.GA2790@elf.ucw.cz>
In-Reply-To: <20060126102250.GA2790@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> Can you include the patch in -mm to give it some testing?  Then merge
>> maybe for 2.6.17?  Posted last time in december, with nobody complaining
>> any more about the most recent version.  The patch is almost unmodified
>> since, I've only had to add a small chunk due to the mutex merge.
>> Description is below, the patch (against -rc1-git4 snapshot) is
>> attached.
> 
> Well, I'm not 100% convinced this is really good idea.. It increases
> complexity quite a lot.

Well, we have alternatives for quite some time already, this is just an
extension of the existing bits ...

> Oh and please inline patches.

Whats wrong with "Content-Disposition: inline" attachments?  The risk
they get whitespace-mangeled is much lower then.  Also mailers display
them inline and also quote them on reply so you can easily comment them.
 At least mutt and thunderbird do that.  If your mailer doesn't file a
bug ;)

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
