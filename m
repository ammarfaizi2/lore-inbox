Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161209AbWASOGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbWASOGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbWASOGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:06:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29417 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161209AbWASOF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:05:59 -0500
Date: Thu, 19 Jan 2006 14:36:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Brown, Len" <len.brown@intel.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: remove function tracing macros
Message-ID: <20060119133655.GA1558@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005B835E4@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005B835E4@hdsmsx401.amr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm sorry, I can't apply this source clean-up patch.
> 
> We need tracing to debug interpreter failures on hardware
> in the field.

Well, it seems very few people actually need that. Perhaps those
people could use separate version of instrumented interpretter?

On Linux, same can probably be done by linker magic etc. Is there
anyone needing instrumentation on *BSD?

							Pavel
-- 
Thanks, Sharp!
