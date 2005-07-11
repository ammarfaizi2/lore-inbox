Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVGKPie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVGKPie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVGKPhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:37:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59790 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261996AbVGKPf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:35:57 -0400
Date: Mon, 11 Jul 2005 17:11:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Micheal Marineau <marineam@engr.orst.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][help?] Radeonfb acpi resume
Message-ID: <20050711151156.GA2001@elf.ucw.cz>
References: <42D19EE1.90809@engr.orst.edu> <42D19FEE.1040306@engr.orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D19FEE.1040306@engr.orst.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Aww crap, thunderbird screwed up the white space...
> 
> A usable version of the patch is attached, or here is a link:
> http://dev.gentoo.org/~marineam/files/patch-radeonfb-2.6.12

Wrong indentation in acpi_vgapost; I remember there was better patch
to fix this out there.

Anyway, are you sure machine you have can't be fixed by any methods
listed in Doc*/power/video.txt? I guess they are preferable to
acpi_vgapost...

If not... indent it acording to the coding style and drop "phony
return code" (it is unneeded, anyway, right?) and try again. (Oh and
Cc me ;-).
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
