Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbTFLUmV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbTFLUmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:42:21 -0400
Received: from web40602.mail.yahoo.com ([66.218.78.139]:61092 "HELO
	web40602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264992AbTFLUmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:42:13 -0400
Message-ID: <20030612205557.5874.qmail@web40602.mail.yahoo.com>
Date: Thu, 12 Jun 2003 13:55:57 -0700 (PDT)
From: Muthian Sivathanu <muthian_s@yahoo.com>
Subject: limit resident memory size
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to limit the maximum resident memory size
of a process within a threshold, i.e. if its virtual
memory footprint exceeds this threshold, it needs to
swap out pages *only* from within its VM space.

First, is there a way this can be done at application
level ? The setrlimit interface seems to contain an
option for specifying max resident set size, but it
doesnt seem like it is implemented as of 2.4 -- am I
wrong ?

If the kernel doesnt currently support it, is there an
efficient way (data structure etc) to traverse the
resident set of a *process* in lru fashion ?  All the
page replacement and swapping code work on the entire
page lists -- is there any simple way to group these
per process ?

thanks for any pointers,
Muthian.

__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
