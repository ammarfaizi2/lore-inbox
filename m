Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274888AbTHPRia (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 13:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274892AbTHPRia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 13:38:30 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:58382 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S274888AbTHPRi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 13:38:29 -0400
To: Greg KH <greg@kroah.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 current - firewire compile error
References: <3F3E288B.3010105@cornell.edu> <20030816163553.GA9735@kroah.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 17 Aug 2003 02:38:16 +0900
In-Reply-To: <20030816163553.GA9735@kroah.com>
Message-ID: <87wuddzenr.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> I removed struct device.name and forgot to change the firewire code :(
> 
> I'll work on a patch for this later this evening, unless someone beats
> me to it.

Why wasn't DEVICE_NAME_SIZE/_HALF killed? Looks like these also should
define by drivers.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
