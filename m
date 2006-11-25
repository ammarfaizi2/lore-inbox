Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967114AbWKYTME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967114AbWKYTME (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967117AbWKYTME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:12:04 -0500
Received: from lug.demon.co.uk ([83.104.159.110]:24112 "EHLO lug.demon.co.uk")
	by vger.kernel.org with ESMTP id S967114AbWKYTMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:12:01 -0500
From: David Johnson <dj@david-web.co.uk>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: Changing sysctl values within the kernel?
Date: Sat, 25 Nov 2006 19:11:48 +0000
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611251911.48961.dj@david-web.co.uk>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm working on a kernel module and want to change sysctl values (specifically 
stop-a and printk) in response to a hardware event.

Is there an accepted way of setting sysctl values within the kernel (I can't 
seem to find any other module doing this), or is it a completely silly idea?

Would it perhaps be better to instead create a sysfs node and let a userspace 
daemon worry about setting the sysctl values?

Any advice greatly appreciated!

David.
