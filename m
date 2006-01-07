Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWAGByE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWAGByE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbWAGByE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:54:04 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:56199 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750798AbWAGByC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:54:02 -0500
From: Grant Coady <gcoady@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davej@codemonkey.org.uk, airlied@linux.ie
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
Date: Sat, 07 Jan 2006 12:53:43 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <jg7ur153n4stkjip13fva21345kqfqiufr@4ax.com>
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com> <20060105162714.6ad6d374.akpm@osdl.org> <9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com> <20060105165946.1768f3d5.akpm@osdl.org> <9a8748490601061625q14d0ac04ica527821cf246427@mail.gmail.com> <20060107002833.GB9402@redhat.com> <20060106164012.041e14b2.akpm@osdl.org>
In-Reply-To: <20060106164012.041e14b2.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006 16:40:12 -0800, Andrew Morton <akpm@osdl.org> wrote:

>Dave Jones <davej@redhat.com> wrote:
>> If only someone did a patch to pause the text output after the first oops..
>> 
>> Oh wait! Someone did!
>> 
...
>I think I did one of those too.  It required a new kernel boot option
>`halt-after-oops' or some such.  Sounds like a good idea?

I'd prefer the halt after oops option, since I often reboot remotely 
(ssh) and may not notice boot failed until I get around to opening 
new ssh session to target.  It's only then that I'll go front the 
sulking target's console ;)

Grant.
