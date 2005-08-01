Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVHAQZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVHAQZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVHAQYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:24:17 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:28053 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S262111AbVHAQR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:17:57 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: 2.6.12.3 Oops
To: Andrew Burgess <aab@cichlid.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 01 Aug 2005 18:17:51 +0200
References: <4wKfb-4Do-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DzczA-0000n6-8M@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Burgess <aab@cichlid.com> wrote:

> This is a busy machine. There is continuous usb soundcard (3 soundcards) and
> usb ethernet activity (news server and alot of downloading) and video is being
> read continuously from the bt878 card.
                             ^^^^^
Let me guess: A VIA mainboard?

If yes, check for files with the first four bytes replaces by garbage
while/after watching TV. If you find some, we've got the same problem.

> Any suggestions for workarounds are greatly appreciated. I'm going to try
> running with swap off and see if that helps.

The no_overlay module option might help, if it were actually implemented.
(I could not find reads from the corresponding variable.)
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
