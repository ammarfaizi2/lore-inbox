Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUFAMq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUFAMq1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 08:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265018AbUFAMq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 08:46:27 -0400
Received: from gprs214-199.eurotel.cz ([160.218.214.199]:13696 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264579AbUFAMq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 08:46:26 -0400
Date: Tue, 1 Jun 2004 14:46:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: Andrey Panin <pazke@donpac.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] 2.6.7-rc1-mm1, Simplify DMI matching data
Message-ID: <20040601124617.GD10233@elf.ucw.cz>
References: <20Oc4-HT-25@gated-at.bofh.it> <m3zn7su4lv.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3zn7su4lv.fsf@averell.firstfloor.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > simplify DMI blacklist table by removing the need to fill
> > unused slots with NO_MATCH macro.
> 
> Can you please delay that patch for 2.7?
> 2.6 is for bug fixes, not for cleanups.

Current DMI setup is terminally broken by keeping whole blacklist in
one place. Fixing it very good idea.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
