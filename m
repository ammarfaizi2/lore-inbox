Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbTBORj5>; Sat, 15 Feb 2003 12:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTBORj5>; Sat, 15 Feb 2003 12:39:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20999 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264631AbTBORj5>; Sat, 15 Feb 2003 12:39:57 -0500
Date: Sat, 15 Feb 2003 18:49:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Alfred E. Heggestad" <linuxedmund@home.no>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix stack handling in acpi_wakeup.S
Message-ID: <20030215174950.GD31778@atrey.karlin.mff.cuni.cz>
References: <20030211184452.GA24966@elf.ucw.cz> <1045311319.14740.25.camel@tellus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045311319.14740.25.camel@tellus>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I applied this patch to 2.5.60 and when doing the
> software suspend it did manage to start the freezing
> process (process X into refrigerator etc...) but crashed
> once in ide.c - apologies I do not have any more details
> and I cannot reproduce that one.

this patch has nothing to do with swsusp. I do not know what goes
wrong in ide.c, but this patch is for orthogonal issue.
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
