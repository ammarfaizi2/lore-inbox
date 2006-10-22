Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWJVW0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWJVW0z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWJVW0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:26:55 -0400
Received: from ns1.suse.de ([195.135.220.2]:22199 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750704AbWJVW0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:26:54 -0400
To: Avi Kivity <avi@qumranet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <200610221723.48646.arnd@arndb.de>
	<453B99D7.1050004@qumranet.com> <200610221851.06530.arnd@arndb.de>
	<453BA3E9.4050907@qumranet.com> <20061022175609.GA28152@infradead.org>
	<453BB1B0.7040500@qumranet.com>
From: Andi Kleen <ak@suse.de>
Date: 23 Oct 2006 00:26:48 +0200
In-Reply-To: <453BB1B0.7040500@qumranet.com>
Message-ID: <p73ac3om1g7.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity <avi@qumranet.com> writes:

> Dropping 32-bit host support would certainly kill a lot of #ifdefs and
> reduce the amount of testing needed.  

Sounds like a good thing.

> It would also force me to upgrade my home machine.

Why? AFAIK there are no VT machines that don't support EM64T.

If you mean you have 32bit userland you can certainly use a 64bit kernel
with 32bit userland.

-Andi
