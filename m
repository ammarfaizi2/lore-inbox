Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271052AbTGPSzR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271056AbTGPSzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:55:17 -0400
Received: from [66.212.224.118] ([66.212.224.118]:37125 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271052AbTGPSzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:55:14 -0400
Date: Wed, 16 Jul 2003 14:58:43 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Nuno Monteiro <nuno.monteiro@ptnix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: woes with 2.6.0-test1 and xscreensaver/xlock
In-Reply-To: <20030716172758.GA1792@hobbes.itsari.int>
Message-ID: <Pine.LNX.4.53.0307161454180.32541@montezuma.mastecende.com>
References: <20030716172758.GA1792@hobbes.itsari.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003, Nuno Monteiro wrote:

> Is anyone else having trouble with xscreensaver/xlock under 2.6.0-test1? 
> Whenever I lock my session using either "lock screen" from the menu (it 
> launches 'xscreensaver lock', afaik) or "xlock", I cant seem to ever get 
> my session back -- I type in the correct password, but they both just 
> hang there. The exact same setup works flawlessly in 2.4.21, and just for 
> the sake of curiosity I also tested 2.5.75, 2.5.74, 2.5.73, 2.5.72, 
> 2.5.71 and 2.5.70, they all exhibit the same behaviour as 2.6.0-test1. I 
> dont really have time to go on testing kernels to find out exactly where 
> it broke, so I'm hoping anyone else is experiencing these woes.

Someone reported this on bugzilla too, but i failed to reproduce it so it 
appears that perhaps something else died like the keyboard. I tried it 
last night on 2.6.0-test1 and i managed to login fine. It does appear that 
something else is dying. It'd be good if you could collect the last few messages 
from /var/log/XFree86.0.log and /var/log/messages and also perhaps 
/var/log/dmesg. 

Thanks,
	Zwane
-- 
function.linuxpower.ca
