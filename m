Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbULFIgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbULFIgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 03:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbULFIgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 03:36:00 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26537 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261391AbULFIf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 03:35:56 -0500
Date: Mon, 6 Dec 2004 09:35:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: host name length
In-Reply-To: <20041203160538.77a22864.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.53.0412060934450.11891@yvahk01.tjqt.qr>
References: <40521AA6.7070308@redhat.com> <20041203160538.77a22864.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>| POSIX nowadays contains
>|
>|   _POSIX_HOST_NAME_MAX
>| and
>|   HOST_NAME_MAX
>|
>| for programs to use to learn about the maximum host name length which is
>| allowed.  _POSIX_HOST_NAME_MAX is the standard-required minimum maximum
>| and the value must be 256.
[...]

Please also consider the DNS FAQ. If a (DNS) hostname cannot be longer than X
chars (I don't have the number handy ATM), HOST_NAME_MAX should not be any
greater than X also.



Jan Engelhardt
-- 
ENOSPC
