Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318882AbSH1QLj>; Wed, 28 Aug 2002 12:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318893AbSH1QLj>; Wed, 28 Aug 2002 12:11:39 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318882AbSH1QLi>;
	Wed, 28 Aug 2002 12:11:38 -0400
Message-Id: <200208281615.g7SGFv903690@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: conman@kolivas.net
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel config 
In-Reply-To: Message from conman@kolivas.net 
   of "Wed, 28 Aug 2002 11:49:51 +1000." <1030499391.3d6c2c3f8cf5e@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Aug 2002 09:15:57 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cliff
> 
> Thanks for your input. I've checked the tests you ran and found that the kernel 
> config was set at default which means preemptible and low latency were 
> disabled. I dont see a way of changing the kernel config, and I need these 
> enabled in the tests. Suggestions?
> 
> Regards,
> Con Kolivas
> 
> 
Thanks for the thanks. We don't have a way to tweak the .config per test 
currently.
The .config is adjusted automagically for the machine type.
However, there is a workaround. The PLM supports chains of patches, so you
could do a short diff from -ck3 with only the switch changes, and that
can be applied to -ck3 (PLM #768) automagically by the PLM. 
If you aren't yet up on the PLM, i'd be glad to do the submitting if you
send me the diff.
cliffw



