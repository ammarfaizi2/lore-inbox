Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272412AbTHIRA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272427AbTHIRA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:00:29 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:21011 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S272412AbTHIRA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:00:29 -0400
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test3 and earlier] no keyboard
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 09 Aug 2003 19:00:27 +0200
Message-ID: <87ptjebwb8.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test3 and earlier provide only a very limited form of console on
a Siemens Primergy H450.

For example, pressing RET yields:

atkbd.c: Unknown key (set 0, scancode 0xed, on isa0060/serio0) pressed.          

So far, I only tested remotedly, using the built-in console
redirection support.  2.4.20 works like a charm (using remote console,
I think we never tested the local one).
