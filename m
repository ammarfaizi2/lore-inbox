Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWCONAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWCONAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 08:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbWCONAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 08:00:13 -0500
Received: from mx1.suse.de ([195.135.220.2]:55691 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751476AbWCONAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 08:00:12 -0500
Date: Wed, 15 Mar 2006 11:37:11 +0100
From: Stefan Seyfried <seife@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: ck@vds.kolivas.org, Jun OKAJIMA <okajima@digitalinfra.co.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: does swsusp suck aftre resume for you? [was Re: Re: Faster resuming of suspend technology.]
Message-ID: <20060315103711.GA31317@suse.de>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060312213228.GA27693@rhlx01.fht-esslingen.de> <20060313100619.GA2136@elf.ucw.cz> <200603132136.00210.kernel@kolivas.org> <20060313104315.GH3495@elf.ucw.cz> <20060313111326.GA29716@rhlx01.fht-esslingen.de> <20060313113631.GA1736@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060313113631.GA1736@elf.ucw.cz>
X-Operating-System: Novell Linux Desktop 10 (i586), Kernel 2.6.16-rc5-git9-2-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 12:36:31PM +0100, Pavel Machek wrote:

> Yes, I can do mem=128M... but then, I'd prefer not to code workarounds
> for machines noone uses any more.

I have machines that cannot be upgraded to more than 192MB and would
like to continue using them :-)

> 3) Does it still suck after setting image_size to high value (no =>
> good, we have simple fix)

no matter how high you set image_size, it will never be bigger than
~64MB on a 128MB machine, or i have gotten something seriously wrong.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
