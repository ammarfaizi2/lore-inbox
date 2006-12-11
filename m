Return-Path: <linux-kernel-owner+w=401wt.eu-S1762695AbWLKJiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762695AbWLKJiR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762699AbWLKJiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:38:17 -0500
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:41739 "EHLO
	webmail.xensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762695AbWLKJiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:38:16 -0500
User-Agent: Microsoft-Entourage/11.2.5.060620
Date: Mon, 11 Dec 2006 09:38:12 +0000
Subject: Re: [Xen-devel] Lots of "swapper: page allocation failure" and
 other memory related messages - 2.6.16-xen0
From: Keir Fraser <keir@xensource.com>
To: Jesper Juhl <jesper.juhl@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <xen-devel@lists.xensource.com>
Message-ID: <C1A2D784.5D2D%keir@xensource.com>
Thread-Topic: [Xen-devel] Lots of "swapper: page allocation failure" and
 other memory related messages - 2.6.16-xen0
Thread-Index: AccdCBMOUbHdEIj7EduICgAX8io7RQ==
In-Reply-To: <200612081336.59361.jesper.juhl@gmail.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On 8/12/06 12:36, "Jesper Juhl" <jesper.juhl@gmail.com> wrote:

> (please keep me on Cc when replying)
> 
> I have a server running Xen that regularly spews the following.
> The box seems to survive fine regardless - just thought I'd let everyone know.

Harmless and not entirely unexpected. I'll add __GFP_NOWARN to the
allocations to quieten things down.

 Thanks,
 Keir

