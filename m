Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271019AbTGQU7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271038AbTGQU7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:59:06 -0400
Received: from web40010.mail.yahoo.com ([66.218.78.28]:634 "HELO
	web40010.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271019AbTGQU7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:59:02 -0400
Message-ID: <20030717211356.53055.qmail@web40010.mail.yahoo.com>
Date: Thu, 17 Jul 2003 14:13:56 -0700 (PDT)
From: Jeff Smith <whydoubt@yahoo.com>
Subject: Re: [PATCH] 2.6.0-test1 Nonexistent Symbols During Config
To: linux-kernel@vger.kernel.org, kwall@kurtwerks.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few notes on each of these.  I do not offer
recommendations, only facts.

CONFIG_X86_SSE:
  Used in include/asm-i386/bugs.h to panic if
  the kernel is compiled for SSE2 but the
  processor does not support it.

CONFIG_NET_PCMCIA_RADIO:
  Used in drivers/net/wireless/ray_cs.c.

CONFIG_INTEL_RNG:
  Not used anywhere in code.

 -- Jeff Smith

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
