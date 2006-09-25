Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWIYLMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWIYLMq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWIYLMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:12:45 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:17895 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751112AbWIYLMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:12:45 -0400
Date: Mon, 25 Sep 2006 13:11:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michiel de Boer <x@rebelhomicide.demon.nl>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <451798FA.8000004@rebelhomicide.demon.nl>
Message-ID: <Pine.LNX.4.61.0609251301030.21631@yvahk01.tjqt.qr>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
 <451798FA.8000004@rebelhomicide.demon.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> What is the stance of the developer team / kernel maintainers on
> DRM, Trusted Computing and software patents? Does the refusal to
> adopt GPLv3 as is mean that these two are more likely to emerge as
> supported functionality in the Linux kernel? Are there any moral
> boundaries Linux kernel developers will not cross concerning
> present and new U.S. laws on technology? Are they willing to put
> that in writing? Will Linux support HD-DVD and BluRay by being
> slightly more tolerant to closed source binary blobs? What about
> the already existant problems with the Content Scrambling System
> for DVD's?

I agree with Neil here. Supporting HD-DVD/BluRay/Other will probably
"as simple" as integrating DVD support into the CD-only source code
back when DVDs where introduced was.

I suppose that HD-DVD drives will use the same ATAPI/SATA commands as
DVD drives do (plus/minus the regular extras). In other words: Data
read from the drive arrives as bytes that are ready to be parsed
according to struct toc / whatever. There is no kernel-level
translation required right now (at least it looks that way), and to
watch a CSS-encrypted video, you need some extra userspace software
to do so. I do not see why HD-DVD/BR should suddenly require a
kernel-level CSS/Other decryptor... or did I miss something and
Windows had a kernel-level deCSS all the time?

> Finally, i hope that the wishes of the community of people that have only
> contributed to the kernel a few times but whose combined work may equal that
> of the core developers, are taken into account; as well as the wishes of
> the massive amount of users of the Linux kernel.
>
> How about a public poll?


Jan Engelhardt
-- 
