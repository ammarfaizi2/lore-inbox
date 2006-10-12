Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWJLOVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWJLOVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWJLOVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:21:49 -0400
Received: from mail.suse.de ([195.135.220.2]:59842 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932479AbWJLOVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:21:48 -0400
From: Andreas Schwab <schwab@suse.de>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       md@linux.it
Subject: Re: 2.6.18 - check for chroot, broken root and cwd values in procfs
References: <20061012140224.GA7632@wavehammer.waldi.eu.org>
X-Yow: Xerox your lunch and file it under ``sex offenders!''
Date: Thu, 12 Oct 2006 16:21:36 +0200
In-Reply-To: <20061012140224.GA7632@wavehammer.waldi.eu.org> (Bastian Blank's
	message of "Thu, 12 Oct 2006 16:02:24 +0200")
Message-ID: <jeodshpqbz.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bastian Blank <bastian@waldi.eu.org> writes:

> Is this a desired output or can I call this a bug? If the behaviour is
> correct, is there a replacement for this check?

[ "$(stat -c "%d/%i" /)" = "$(stat -Lc "%d/%i" /proc/1/root)" ]

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
