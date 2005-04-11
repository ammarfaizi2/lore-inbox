Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVDKHmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVDKHmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 03:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVDKHmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 03:42:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:63468 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261721AbVDKHl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 03:41:58 -0400
Message-ID: <425A2385.2000306@suse.de>
Date: Mon, 11 Apr 2005 09:13:09 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
References: <42592697.8060909@domdv.de> <200504102040.38403.oliver@neukum.org> <42597E99.8010802@domdv.de> <200504102203.29602.oliver@neukum.org> <20050410201455.GA21568@elf.ucw.cz>
In-Reply-To: <20050410201455.GA21568@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Encrypting swsusp image is of course even better, because you don't
> have to write large ammounts of zeros to your disks during resume ;-).

and while we are at it: compressing before encryption will also reduce
the amount of data you have to write during suspend... ;-)

> 								Pavel

Stefan

