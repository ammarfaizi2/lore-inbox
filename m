Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbUKNWoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbUKNWoR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 17:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUKNWoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 17:44:17 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:5857 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261359AbUKNWoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 17:44:15 -0500
Subject: Re: 2.6.9: unkillable processes during heavy IO
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brad Fitzpatrick <brad@danga.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411141403040.22805@danga.com>
References: <Pine.LNX.4.58.0411141403040.22805@danga.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100468463.25613.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 14 Nov 2004 21:41:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-11-14 at 22:15, Brad Fitzpatrick wrote:
> Next time it hangs like this, how can I get a kernel backtrace or other useful information
> for a certain process?

See what is in dmesg and /var/log/messages. Use ps to get the waitqueue
of the
stuck processes (see man ps)

