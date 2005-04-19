Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVDSOqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVDSOqh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVDSOqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:46:37 -0400
Received: from web88101.mail.re2.yahoo.com ([206.190.37.202]:12442 "HELO
	web88101.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261513AbVDSOqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:46:22 -0400
Message-ID: <20050419144621.95824.qmail@web88101.mail.re2.yahoo.com>
Date: Tue, 19 Apr 2005 10:46:21 -0400 (EDT)
From: Anthony Russello <arussello@rogers.com>
Subject: hang in rest_init, kernel_thread call 2.6.12-rc2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm currently trying to bring 2.6.12-rc2 up on a board
using the Freescale 8240 CPU.  I'm also using, for the
most part, the sandpoint platform specific code.

Currently I am experiencing a hang in the function
rest_init within init/main.c when the kernel attempts
to kick off its init thread:

kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);

Has anyone seen this behaviour before?

Currently, in order to debug this I've been writing a
single character out to the address where the serial
port lies.  That is how I've been able to determine
exactly where I'm stuck.

Has anyone else come across this?  If so, how were you
able to debug it?  I'd appreciate any tips or tricks
you might be able to give.

Thank you in advance for any help you might be able to
offer.

Cheers,
Anthony
