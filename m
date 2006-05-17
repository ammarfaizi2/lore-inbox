Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWEQNZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWEQNZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWEQNZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:25:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58019 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932274AbWEQNZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:25:14 -0400
Subject: Re: libata PATA updated patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Radloff <radsaq@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3b0ffc1f0605170558h5072b407pa4127abe3743553f@mail.gmail.com>
References: <1147796037.2151.83.camel@localhost.localdomain>
	 <3b0ffc1f0605161303paabdbfk56fe91e4156fe085@mail.gmail.com>
	 <3b0ffc1f0605170558h5072b407pa4127abe3743553f@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 14:38:16 +0100
Message-Id: <1147873096.10470.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-17 at 08:58 -0400, Kevin Radloff wrote:
> Okay, I was wrong. :( Sometimes the IDE adapter doesn't resume after
> unsuspending (suspend to RAM) or something like that. Whatever is
> happening the disks are inaccessible though, so it's hard to get the
> exact details.

Linux does not support suspend/resume with any kind of IDE disk, PATA or
SATA. It happens to work for many cases. Full suspend/resume support is
on its way and some of it should be in 2.6.18 or so.

