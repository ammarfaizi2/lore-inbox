Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWGBE0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWGBE0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 00:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWGBE0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 00:26:07 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:3227 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932369AbWGBE0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 00:26:06 -0400
Date: Sat, 01 Jul 2006 22:26:01 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59:
 undefined reference to `__stack_chk_fail'
In-reply-to: <fa.LW8cO+QP5MhBZ9HST2AOy+N/e6o@ifi.uio.no>
To: Miles Lane <miles.lane@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Message-id: <44A74AD9.70202@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.WuLfTz/aICPisBh2gZXGQmS9xvs@ifi.uio.no>
 <fa.LW8cO+QP5MhBZ9HST2AOy+N/e6o@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
 > Trying to compile, I get:
 >
 > include/asm/system.h: In function '__set_64bit_var':
 > include/asm/system.h:209: warning: dereferencing type-punned pointer
 > will break strict-aliasing rules

Sounds like you're still getting a bunch of bad compile flags passed in. 
You likely need to remove the CFLAGS from your shell environment or 
something so that the kernel build stops inheriting them all.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


