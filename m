Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269700AbUJMNTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269700AbUJMNTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 09:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269704AbUJMNTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 09:19:24 -0400
Received: from zamok.crans.org ([138.231.136.6]:39833 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S269700AbUJMNTH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 09:19:07 -0400
To: Jesse Stockall <stockall@magma.ca>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
References: <20041011032502.299dc88d.akpm@osdl.org>
	<1097672832.5500.60.camel@homer.blizzard.org>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Wed, 13 Oct 2004 15:19:09 +0200
In-Reply-To: <1097672832.5500.60.camel@homer.blizzard.org> (Jesse Stockall's
	message of "Wed, 13 Oct 2004 09:07:12 -0400")
Message-ID: <87r7o23gdu.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Stockall <stockall@magma.ca> disait dernièrement que :

> On Mon, 2004-10-11 at 06:25, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/
>> 
>> - I wasn't going to do any -mm's until after 2.6.9 comes out.  But we need
>>   this one so that people who have patches in -mm can check that I haven't
>>   failed to push anything critical.  If there's a patch in here which you
>>   think should be in 2.6.9, please let me know.
>> 
>
> Hi
>
> I'm have a Gentoo box and with either 2.6.9-rc4-mm1 or 2.6.9-rc3-mmX
> mozilla-firefox, mozilla-thunderbird, gaim segfault on launch. The Gnome
> desktop env (panel, window manager, etc) run normally.
>
> Rebooting to 2.6.9-rc4 and everything is back to normal.
>
> I have seen 1 other user on #gentoo with the same problem.
>
> Tried with preemptable-blk on and off.

here's a fix
cd /usr/src/linux-2.6.9-rc4-mm1
wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/optimize-profile-path-slightly.patch
patch -R -p1 < optimize-profile-path-slightly.patch

this should fix the sources and so...

>
> strace, config and dmesg atached.
>
> Thanks

-- 
/* Allow the packet buffer size to be overridden by know-it-alls. */

	- comment from drivers/net/ne.c

