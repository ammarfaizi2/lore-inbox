Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbTDINAP (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 09:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbTDINAP (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 09:00:15 -0400
Received: from denise.shiny.it ([194.20.232.1]:47022 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S263300AbTDINAO (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 09:00:14 -0400
Message-ID: <XFMail.20030409151149.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3E93A958.80107@si.rr.com>
Date: Wed, 09 Apr 2003 15:11:49 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Frank Davis <fdavis@si.rr.com>
Subject: RE: kernel support for non-english user messages
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09-Apr-2003 Frank Davis wrote:
> All,
>
> I wish to suggest a possible 2.6 or 2.7 feature (too late for 2.4.x and
> 2.5.x, I believe) that I believe would be helpful. Currently, printk
> messages are all in english, and I was wondering if printk could be
> modified to print out user messages that are in the default language of
> the machine. For example,
> printk(KERN_WARN "This driver is messed up!\n", getdefaultlanguage());

IMHO the "translation" should be performed at compile time. All those
languages would bloat the kernel image too much.


Bye.

