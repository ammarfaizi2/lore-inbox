Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWCTWWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWCTWWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWCTWWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:22:44 -0500
Received: from cantor2.suse.de ([195.135.220.15]:61155 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751146AbWCTWWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:22:42 -0500
From: Andreas Schwab <schwab@suse.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: lstat returns bogus values.
References: <Pine.LNX.4.61.0603201312320.23345@chaos.analogic.com>
	<jed5ggx39x.fsf@sykes.suse.de>
	<Pine.LNX.4.61.0603201655370.25162@chaos.analogic.com>
X-Yow: What I want to find out is -- do parrots know much about Astro-Turf?
Date: Mon, 20 Mar 2006 23:22:40 +0100
In-Reply-To: <Pine.LNX.4.61.0603201655370.25162@chaos.analogic.com>
	(linux-os@analogic.com's message of "Mon, 20 Mar 2006 17:04:12 -0500")
Message-ID: <jeslpcvjrj.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os (Dick Johnson)" <linux-os@analogic.com> writes:

> `ls` only means something when there is a file-system so `ls`
> is not appropriate until you have a file-system.

ls just calls lstat on the device node.  It doesn't read the device.

> I think lstat should return -1 and the appropriate error code
> should be in errno (perhaps ENOMEDIUM).

But the cdrom device node exists as a file.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
