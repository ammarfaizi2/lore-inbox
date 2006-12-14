Return-Path: <linux-kernel-owner+w=401wt.eu-S932695AbWLNMbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWLNMbb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWLNMbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:31:31 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44629 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932695AbWLNMba convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:31:30 -0500
Date: Thu, 14 Dec 2006 12:39:45 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: =?UTF-8?B?SGFucy1Kw7xyZ2Vu?= Koch <hjk@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061214123945.734b5261@localhost.localdomain>
In-Reply-To: <200612141056.03538.hjk@linutronix.de>
References: <20061213195226.GA6736@kroah.com>
	<Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
	<200612140949.43270.duncan.sands@math.u-psud.fr>
	<200612141056.03538.hjk@linutronix.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 10:56:03 +0100
Hans-Jürgen Koch <hjk@linutronix.de> wrote:

> * They let somebody write the small kernel module they need to handle 
> interrupts in a _clean_ way. This module can easily be checked and could
> even be included in a mainline kernel.

And might as well do the mmap work as well. I'm not clear what uio gives
us that a decently written pair of PCI and platform template drivers for
people to use would not do more cleanly.

Also many of these cases you might not want stuff in userspace but the
uio model would push it that way which seems to be an unfortunate side
effect. Yes some probably do want to go that way but not all.

