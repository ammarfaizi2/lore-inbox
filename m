Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269079AbUJQIU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269079AbUJQIU7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 04:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269080AbUJQIU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 04:20:59 -0400
Received: from cantor.suse.de ([195.135.220.2]:1769 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269079AbUJQIU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 04:20:57 -0400
Date: Sun, 17 Oct 2004 10:20:56 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew <cmkrnl@speakeasy.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-2.6.9.rc4 lib/kobject.c
Message-ID: <20041017082056.GA30109@suse.de>
References: <4171EB60.50800@speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4171EB60.50800@speakeasy.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Oct 16, Andrew wrote:

> Some user space programs (rightly or wrongly) are expecting there would 
> be no "gaps" in hotplug event sequence numbers, and hang waiting for the 
> "missing" events.

Every code that relies on the value of $SEQNUM is just broken.
The only valid check is < or >

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
