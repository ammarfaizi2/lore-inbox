Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVGMLD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVGMLD3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVGMLAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 07:00:23 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:29637 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262687AbVGMK7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:59:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux v2.6.13-rc3
Date: Wed, 13 Jul 2005 12:59:04 +0200
User-Agent: KMail/1.8.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507131259.04855.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 13 of July 2005 07:05, Linus Torvalds wrote:
> 
> Yes,
>  it's _really_ -rc3 this time, never mind the confusion with the commit 
> message last time (when the Makefile clearly said -rc2, but my over-eager 
> fingers had typed in a commit message saying -rc3).
> 
> There's a bit more changes here than I would like, but I'm putting my foot 
> down now. Not only are a lot of people going to be gone next week for LKS 
> and OLS, but we've gotten enough stuff for 2.6.13, and we need to calm 
> down.

FYI, on my box (Asus L5D, Athlon 64 + nForce3, 64-bit kernel) there are two
regressions wrt -rc2 related to ACPI.  First, the battery monitor does not work
(http://bugzilla.kernel.org/show_bug.cgi?id=4665)
and second, the box hangs solid during resume from disk if IO-APIC is not used
(http://bugzilla.kernel.org/show_bug.cgi?id=4416).

The problems have been known for quite some time and remain unresolved,
but apparently they have made it to mainline nevertheless.  I understand
nobody else has reported them, but I also know of some people who run
Linux on the same hardware and 2.6.13 will not work for them if these
issues are present in it.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
