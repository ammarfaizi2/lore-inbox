Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263047AbTEBSFC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbTEBSFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:05:02 -0400
Received: from gw.enyo.de ([212.9.189.178]:32005 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S263047AbTEBSFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:05:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
References: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com> <Pine.LNX.4.50.0305020948550.1904-100000@blue1.dev.mcafeelabs.com>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 02 May 2003 20:17:25 +0200
In-Reply-To: <20030502172011$0947@gated-at.bofh.it> (Davide Libenzi's
 message of "Fri, 02 May 2003 19:20:11 +0200")
Message-ID: <87llxp43ii.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> Ingo, do you want protection against shell code injection ? Have the
> kernel to assign random stack addresses to processes and they won't be
> able to guess the stack pointer to place the jump.

If your software is broken enough to have buffer overflow bugs, it's
not entirely unlikely that it leaks the stack address as well (IIRC,
BIND 8 did).
