Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVK0CaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVK0CaT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 21:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVK0CaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 21:30:19 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:59022 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750818AbVK0CaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 21:30:17 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Reading another process memory?
To: Mohamed El Dawy <msdawy@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 27 Nov 2005 03:30:56 +0100
References: <5diU3-59M-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EgCJc-00019T-VX@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohamed El Dawy <msdawy@gmail.com> wrote:

> I am trying to write  a function that involves reading other processes
> memory.

Most likely you should
a) use ptrace.
b) use shared memory.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
