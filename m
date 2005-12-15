Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbVLONMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbVLONMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVLONMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:12:42 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:33768 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965204AbVLONMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:12:41 -0500
Date: Thu, 15 Dec 2005 14:12:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH 3/3] m68k: compile fix - updated vmlinux.lds to include
 LOCK_TEXT
In-Reply-To: <20051215090037.GV27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0512151408560.1605@scrub.home>
References: <20051215090037.GV27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Dec 2005, Al Viro wrote:

> [rz: BTW, proposed variant of thread_info patchset is available for review,
> see ftp.linux.org.uk/pub/people/viro/task_thread_info-mbox...

BTW please fix the comment in the last patch, {get,put}_thread_info() 
didn't come from the m68k tree, so don't blame it for this stuff.
The thread_info stuff went through a number changes during 2.5.xx and it's 
a leftover from this.

bye, Roman
