Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272367AbTGaAHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272368AbTGaAHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:07:44 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:21449 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S272367AbTGaAHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:07:42 -0400
Message-ID: <3F2861D3.4030703@genebrew.com>
Date: Wed, 30 Jul 2003 20:24:51 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefano Rivoir <s.rivoir@gts.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0t2 Hangs randomly
References: <3F27817A.8000703@gts.it>
In-Reply-To: <3F27817A.8000703@gts.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir wrote:
> 
> I'm experiencing hard rand lockups using kernel 2.6.0: they are not
> predictable, nor I can find a way to reproduce them. They can occur
> while working with an app, while browsing the fs (I use KDE) or
> while resuming after the screensaver, or anything else. They can
> occur after one hour or 15 minutes, and there's not any strange
> "jerkiness" activity before, nor an intense disk work.
> 
> After the hang, the disk starts working for a while, then I have
> to reset w/button, and nothing is left on the various system logs.
> 
> These hangs did not occur in 2.5 up to .75, but they come also
> with 2.6.0-mm1 (and plain 2.6.0-t1). I had a doubt about the
> soundcard, I've applied latest 0.9.6 alsa patch: the hangs are less 
> frequent but still there.

Can you reproduce these hangs without the AGP and DRI modules loaded?

Thanks,
Rahul
-- 
Rahul Karnik
rahul@genebrew.com

