Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWCOSIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWCOSIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 13:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWCOSIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 13:08:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64775 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750993AbWCOSIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 13:08:36 -0500
Date: Wed, 15 Mar 2006 17:59:48 +0000
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: ck@vds.kolivas.org, Jun OKAJIMA <okajima@digitalinfra.co.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: does swsusp suck aftre resume for you? [was Re: Re: Faster resuming of suspend technology.]
Message-ID: <20060315175948.GB2423@ucw.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060312213228.GA27693@rhlx01.fht-esslingen.de> <20060313100619.GA2136@elf.ucw.cz> <200603132136.00210.kernel@kolivas.org> <20060313104315.GH3495@elf.ucw.cz> <20060313111326.GA29716@rhlx01.fht-esslingen.de> <20060313113631.GA1736@elf.ucw.cz> <20060315103711.GA31317@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315103711.GA31317@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 15-03-06 11:37:11, Stefan Seyfried wrote:
> On Mon, Mar 13, 2006 at 12:36:31PM +0100, Pavel Machek wrote:
> 
> > Yes, I can do mem=128M... but then, I'd prefer not to code workarounds
> > for machines noone uses any more.
> 
> I have machines that cannot be upgraded to more than 192MB and would
> like to continue using them :-)

Good :-).

> > 3) Does it still suck after setting image_size to high value (no =>
> > good, we have simple fix)
> 
> no matter how high you set image_size, it will never be bigger than
> ~64MB on a 128MB machine, or i have gotten something seriously wrong.

No, you are right, but maybe 64MB image is enough to get acceptable
interactivity after resume? I'd like you to check it.

(It will probably suck. In such case, testing Con's patch would be
nice -- after trivial fix rafael pointed out).
								Pavel
-- 
Thanks, Sharp!
