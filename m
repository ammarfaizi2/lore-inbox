Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTHYNzt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 09:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbTHYNzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 09:55:48 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:38852 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261829AbTHYNvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 09:51:41 -0400
Date: Mon, 25 Aug 2003 15:51:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: paul.devriendt@amd.com
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, aj@suse.de,
       mark.langsdorf@amd.com, richard.brunner@amd.com
Subject: Re: Cpufreq for opteron
Message-ID: <20030825135126.GC740@elf.ucw.cz>
References: <99F2150714F93F448942F9A9F112634C080EF010@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C080EF010@txexmtae.amd.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 4) given good hardware and debugged driver, will any of those
> > BUG_ON()s ever trigger?
> 
> Only if there are BIOS problems. 

In such case, I believe best idea is to leave them in as BUG_ON(). On
broken BIOS, it will kill machine cleanly, and hopefully bios is going
to be fixed.

If broken BIOS is seen in retail, we'll need to solve this other way.

Does this seem okay to you?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
