Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVGEQKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVGEQKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVGEQGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:06:36 -0400
Received: from 39.3.78.83.cust.bluewin.ch ([83.78.3.39]:42288 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261906AbVGEPwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:52:51 -0400
Date: Tue, 5 Jul 2005 17:52:49 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Sending ethernet frames one after another
Message-ID: <20050705155249.GA11451@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have written a software to test connected optical datalink in loopback
mode which works by sending a burst of e. g. 1024 raw Ethernet frames
directly to that interface, then waiting a little bit, and counting from
ifconfig how many were received.

Some people report a problem that on their eepro100 in IBM Thinkpad, the
program (probably sendto) is returning error "No buffer space available".

Why doesn't the sendto block instead? Does it mean that I cannot use
this testing mode with that card? I need to send as fast as possible,
because it's necessary to constantly transmit, as the link must be
tested in load going in both directions simultaneously, to catch
possible crosstalks.

Or is that an error that should be handled by the application? In which
way, then?

Regards,

CL<



