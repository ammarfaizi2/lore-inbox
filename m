Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTIUN0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 09:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTIUN0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 09:26:37 -0400
Received: from mail.g-housing.de ([62.75.136.201]:47848 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262403AbTIUN0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 09:26:35 -0400
Message-ID: <3F6DA70A.6030100@g-house.de>
Date: Sun, 21 Sep 2003 15:26:34 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030917
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lockups with 2.4.2x
References: <3F6D134E.2080505@g-house.de> <20030921053816.GD589@alpha.home.local>
In-Reply-To: <20030921053816.GD589@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hmmm, there is a lot of hardware in this box. Have you tried disabling IDE ?
> ServeRaid ? SymBIOS ?

hm, yes, i could disable the ServeRaid module. gotta find out how to 
disable the builtin IDE / Symbios other than recompile the kernel...

can i do this by giving "ide0=noprobe ide1=noprobe ..." on the 
boot-prompt? my rootdisk used to be on hda, will see if i can do something.

> Also, the DMESG shows that you have an AMD bug on your CPUs, and tells you
> that if you have problems, you should restart with 'noapic'. Did you try it ?

Oh, no, I did not. sorry. i'll try it.

> You could also try to boot in 'nosmp' mode, and even with network unplugged.

hm, will try this too.

> I believe it will be relatively quick to find the problem if the system
> usually hangs in no more than 3 minutes.

the worst thing on this machine is the pre-booting process, where all 
the controllers are "Initializing..."  and "Checking...", and even the 
ServRaid controller wants to have 3 minutes sometimes to settle :-)

> You may also have a defect in your RAM.

even it is "ECC" RAM, i'll give it a try.

Thank your for the quick reply, i'll try these things out, will take 
some time, so maybe i'm back in the evening.

Christian.
(if I only could use my .sig this time :-))
-- 
BOFH excuse #301:

appears to be a Slow/Narrow SCSI-0 Interface problem


