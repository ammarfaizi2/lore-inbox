Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264674AbTE1LLh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264675AbTE1LLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:11:37 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:44433 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264674AbTE1LLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:11:36 -0400
Date: Wed, 28 May 2003 13:24:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.70: CODA breaks boot
Message-ID: <20030528112437.GA442@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...it oopses in kmem_cache_create, called from release_console_sem and
coda_init_inodecache.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
