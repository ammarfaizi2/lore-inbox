Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUKAJJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUKAJJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 04:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbUKAJJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 04:09:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37528 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261654AbUKAJJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 04:09:50 -0500
Date: Mon, 1 Nov 2004 10:09:48 +0100
From: Jan Kara <jack@suse.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-ID: <20041101090948.GC10059@atrey.karlin.mff.cuni.cz>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz> <20041029024651.1ebadf82.akpm@osdl.org> <yw1xu0sdiwr2.fsf@inprovide.com> <20041029133527.GA25172@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.53.0410291632310.16820@yvahk01.tjqt.qr> <20041029145022.GA31945@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.53.0410291651530.18142@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0410291651530.18142@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >  It's not about the kernel size but about allowing user to invoke just
> >some functions and not the other (see my other mail).
> 
> That's like giving a user m$ windows without the ctrl+alt+del functionality,
> if you omit considering that either os has a different level of stability.
  Yes. Some of the sysrq are considered insecure - for example OOM
kill, which was added lately, can be used to kill some process and I
could imagine security implications from cleverly killing syslogd (or
some other important process) by it. OTOH some other functionalities
are useful and safe...

> But I like the idea. Maybe a bitmask which can be set via /proc/sys/.../xxx?
  And that is exactly what the patch does ;).

									Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
