Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264441AbTCXWC1>; Mon, 24 Mar 2003 17:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264443AbTCXWBo>; Mon, 24 Mar 2003 17:01:44 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2052 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264441AbTCXWAp>;
	Mon, 24 Mar 2003 17:00:45 -0500
Date: Mon, 24 Mar 2003 19:07:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: security of fileutils (Re: Release of 2.4.21)
Message-ID: <20030324180757.GB1083@zaurus.ucw.cz>
References: <20030320200019_6ddc@gated-at.bofh.it> <20030320203015_4839@gated-at.bofh.it> <8765qdg46i.fsf@deneb.enyo.de> <20030320210305.GH8256@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320210305.GH8256@gtf.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This specific ptrace hole is closed, yay.  Now what about the other
> 10,001 that still exist?  People are blowing this ptrace bug WAY
> out of proportion.   The only reason why it demands a modicum of
> vendor responsibility is that a-holes are making easy-to-use exploits
> available for the script kiddies.
> 
> In my more cynical moods, I wish bugtraq'ers would start posting
> exploits to all the races in GNU coreutils (cp/mv/rm/...).  Assuming
> such actions would (finally) lead to bug fixes.... maybe then I will
> start taking local root holes a bit more seriously.  I will no more
> than hint about this in public, but will respond privately with details
> (if I know you).

Can you give me the details? I can
imagine holes like "if I can force root
to rm -rf /tmp/my-dir while my scripts
are running, I can rm whatever I want"
and probably could force root to cp
files he did not want to copy, but that
would require a *lot* of social ingeneering...
Unlike ptrace which seems to be "gimme root, now!"
case.
				Pavel
(I left l-k in cc, you may want to strip it)
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

