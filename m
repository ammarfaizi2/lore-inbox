Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVBPQdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVBPQdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVBPQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:33:52 -0500
Received: from main.gmane.org ([80.91.229.2]:42685 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262070AbVBPQdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:33:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Reinhard Tartler <siretart@stud.uni-erlangen.de>
Subject: Re: Thinkpad R40 freezes after swsusp resume
Date: Wed, 16 Feb 2005 16:16:38 +0000 (UTC)
Message-ID: <slrnd16sk6.4g9.siretart@faui06.informatik.uni-erlangen.de>
References: <20050210124636.GA10677@butterfly.hjsoft.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: faui06.informatik.uni-erlangen.de
User-Agent: slrn/0.9.8.1 (Debian)
X-Gmane-MailScanner: Found to be clean
Cc: linux-thinkpad@linux-thinkpad.org
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John M Flinchbaugh wrote:
> I can suspend my R40 with swsusp, then boot it and resume fine most of
> the time.
>
> I'd say nearly 50$ of the time though, the machine will freeze within 5
> minutes of resuming.
>
> SysRq doesn't work, no oops when in console mode, no network, no disk=20
> activity, just frozen.  Occassionally, I've seen a line or 2 of=20
> pixels on my X screen get corrupted.

Do you happen to use the madwifi drivers? If you are you might be
affected by bad interaction from madwifi with laptop mode patches. This
has been reported to ubuntu in
https://bugzilla.ubuntu.com/show_bug.cgi?id=6108

Unfortunatly, the only known fix up to now is to disable either madwifi
oder laptop-mode. :(

I'm also affected by this bug, and find this very annoying. Please CC:
when replying.

Greetings,
        Reinhard


