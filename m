Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVCALQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVCALQM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVCALQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:16:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18637 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261873AbVCALQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:16:05 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       barryn@pobox.com, marado@student.dei.uc.pt,
       acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
References: <20050228231721.GA1326@elf.ucw.cz>
	<20050301015231.091b5329.akpm@osdl.org>
	<20050301105448.GG1345@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Mar 2005 04:12:50 -0700
In-Reply-To: <20050301105448.GG1345@elf.ucw.cz>
Message-ID: <m1psyjr559.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Yes, the patch is very ugly. If something like this needs to be done,
> then perhaps acpi should properly register into driver model and do
> the work there. This will also mean code will be called consistently.

I totally agree.  Do you have an example of how a non-device
can do this?

In particular something that gets as close to shutting down
the system devices as possible.  But gets called before that.

Or perhaps acpi should simply be setup to be the first system device?

Eric
