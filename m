Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbULZMLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbULZMLm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 07:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbULZMLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 07:11:42 -0500
Received: from albireo.enyo.de ([212.9.189.169]:62701 "EHLO albireo.enyo.de")
	by vger.kernel.org with ESMTP id S261638AbULZMLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 07:11:41 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 typo in include/linux/netfilter.h
References: <200412260917.38717.nick@linicks.net>
	<200412261059.57661.nick@linicks.net>
	<20041226132047.6ac71b4f@hotline4.alkar.net>
	<200412261136.18751.nick@linicks.net>
Date: Sun, 26 Dec 2004 13:11:39 +0100
In-Reply-To: <200412261136.18751.nick@linicks.net> (Nick Warne's message of
	"Sun, 26 Dec 2004 11:36:18 +0000")
Message-ID: <878y7lfedg.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Warne:

> I just DL'ed the tar.gz - that is OK.
>
> The image build I done (using oldconfig) booted, but wouldn't mount disks, and 
> a few other errors (like looking for modules - I don't build with modules).
>
> What on earth could cause that then?  Corrupt download?  

Probably that, or a flipped bit on your system.

You should download the .tar.bz2 file again and compare it to the
first one.

> I would have thought nigh on impossible to get one or two errors
> like that if so?

The TCP checksum does not guard against systematic bit errors in
router memory chips, unfortunately.
