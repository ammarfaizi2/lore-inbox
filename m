Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTLHSvX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTLHSvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:51:23 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:41993 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S261613AbTLHSvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:51:21 -0500
Message-ID: <3FD4CC7B.8050107@nishanet.com>
Date: Mon, 08 Dec 2003 14:09:47 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: udev sysfs docs Re: State of devfs in 2.6?
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com>
In-Reply-To: <20031208154256.GV19856@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Mon, Dec 08, 2003 at 03:36:26PM +0000, Andrew Walrond wrote:
>  
>
>>Whats the general feeling about devfs now? I remember Christoph and others 
>>making some nasty remarks about it 6months ago or so, but later noted 
>>christoph doing some slashing and burning thereof.
>>Is it 'nice' yet? 
>>Andrew Walrond
>>    
>>
>
>I would say it's deprecated at the very least. sysfs and udev are
>supposed to provide equivalent functionality, albeit by a somewhat
>different mechanism.
>
>
>-- wli
>
Where can we find documentation on sysfs and udev,
and on transition issues? I know devfs hasn't been
maintained for a long time but the documentation for
it comes with kernel source and there it is in menuconfig.
Every time I hear that udev and sysfs replace devfs I
wonder where to pick up the thread, where is that doc,
where is the menuconfig option ;-)  I guess there is a
website but to bring people out of devfs with their
/etc/devfs/compat_symlinks necessary to boot so
they will have to manually make edits, it would be
necessary to research the manual edits it takes to boot
(md0 vs. md/0, tty vs. vc, etc., /etc/inittab, maybe
etc pam or security ).

If transitioning from devfs to udev sysfs comes
down to one mistake so I can't boot and have to lilo
  append="rw init=/bin/bash" and edit /etc/innitab
then I need the doc on boot partition to make the
last edits to transition completely and save myself
(not docs on a website). Shouldn't udev sysfs doc
come with kernel source(maybe it does!?)?

-Bob

