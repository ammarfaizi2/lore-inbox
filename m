Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423420AbWBBKFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423420AbWBBKFe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423386AbWBBKFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:05:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44684 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422950AbWBBKFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:05:33 -0500
Date: Thu, 2 Feb 2006 11:05:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060202100522.GB1981@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201113710.6320.68289.stgit@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This set of patches represents the core of Suspend2's module support.
> 
> Suspend2 uses a strong internal API to separate the method of
> determining the content of the image from the method by which it is saved.
> The code for determining the content is part of the core of Suspend2, and
> transformations (compression and/or encryption) and storage of the pages are
> handled by 'modules'.

swsusp already has a very strong API to separate image writing from
image creation (in -mm patch, anyway). It is also very nice, just
read() from /dev/snapshot. Please use it.

								Pavel
-- 
Thanks, Sharp!
