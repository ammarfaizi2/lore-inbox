Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265377AbUGDDYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUGDDYW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 23:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbUGDDYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 23:24:22 -0400
Received: from colin2.muc.de ([193.149.48.15]:20235 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265377AbUGDDYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 23:24:17 -0400
Date: 4 Jul 2004 05:24:15 +0200
Date: Sun, 4 Jul 2004 05:24:15 +0200
From: Andi Kleen <ak@muc.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 KBUILD_IMAGE
Message-ID: <20040704032415.GB90194@muc.de>
References: <20040704012732.GW21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704012732.GW21066@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 06:27:32PM -0700, William Lee Irwin III wrote:
> x86_64 doesn't set KBUILD_IMAGE, and hence defaults to vmlinux. This
> confuses make rpm in such a manner that it copies a raw ELF executable
> to /boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION instead of
> the expected bzImage, which is surprisingly unbootable and not what's
> normally expected to be placed in /boot/ with that filename.
> 
> Just setting the variable is enough to convince it to use bzImage properly.

Applied. Thanks.

-Andi
