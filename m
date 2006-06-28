Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWF1GJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWF1GJY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 02:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWF1GJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 02:09:24 -0400
Received: from zephyrus.gaugusch.at ([212.236.250.103]:38537 "EHLO
	mail.gaugusch.at") by vger.kernel.org with ESMTP id S1030376AbWF1GJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 02:09:24 -0400
Date: Wed, 28 Jun 2006 08:09:19 +0200 (CEST)
From: Markus Gaugusch <markus@gaugusch.at>
To: Pavel Machek <pavel@ucw.cz>
Cc: Suspend2-Devel <suspend2-devel@lists.suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: Suspend2 - Request for review & inclusion	in	-mm
In-Reply-To: <20060627190323.GA28863@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0606280754370.15592@zephyrus.gaugusch.at>
References: <200606270147.16501.ncunningham@linuxmail.org>
 <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au>
 <20060627190323.GA28863@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Pavel (and others),

I've been a suspend user since the early days (when Gabor Kuti was working 
on it!), and I think it is really a shame that there are so many 
issues even after 5+ years.
I've recently upgraded my desktop to SuSE 10.1 with a SuSE 2.6.16 kernel 
and swsusp. It's basically working, but for example my serial interface 
with a ds2408 one wire controller attached doesn't work post resume. This 
has NEVER been a problem with suspend2 (also up to 2.6.16).

You might know that I'm the developer of Fast Online Update for SuSE 
(fou4s). The main thing about an online update is comparing versions of 
installed packages with those in the update descriptions. In the early 
days I had some packages that were just too different, so my algorithm 
didn't work. Lars Ellenberg sent me a patch with a completely rewritten 
version update code. You know, this was the HEART of my Software, and now 
I had to replace it with foreign code!? I could have told my users to wait 
another year or two and use YaST OnlineUpdate for those packages instead. 
But I decided to dump my own code in favor of -- THE USERS.

As a developer, I understand your pain to dump optimized, nice-written and 
maintainable (at least for you!) code. But who is it that we are 
developing for? Think about the USERS! There are bugs in swsusp and 
there are features (like pressing Escape during suspend) that make life 
just so much better with suspend2.

Pavel, please go beyond yourself and try to work together with Nigel. I 
know that this is hard, but in the end all people will be happy, even YOU!

regards,
Markus

-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus(at)gaugusch.at  X     Against HTML Mail
                       / \
