Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268487AbUHaNmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268487AbUHaNmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 09:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268488AbUHaNmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 09:42:18 -0400
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:55812 "EHLO
	smtp-vbr2.xs4all.nl") by vger.kernel.org with ESMTP id S268487AbUHaNmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 09:42:03 -0400
Message-ID: <20040831154157.6fnvoq04ssow00so@www.wagland.net>
Date: Tue, 31 Aug 2004 15:41:57 +0200
From: Paul Wagland <paul@kungfoocoder.org>
To: Alexander Stohr <Alexander.Stohr@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-utility] remove whitespaces from kernel sources (for
	any kernel version)
References: <17345.1093954271@www23.gmx.net>
In-Reply-To: <17345.1093954271@www23.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31 Aug 2004 02:11:11 PM CEST, Alexander Stohr wrote:

> Hello,
>
> for current 2.6.x kernel a resulting diff had a size
> of about 24 MB unpacked. i suppose that other kernel
> trees will compare to this magnitude.

Don't forget though, that the actual file difference will be about 200K over a
34M tree... not trivial, but nowhere near that size of that diff file ;-)

> this means the linux kernel source has an interesting potential
> for optimisation which will result in smaller tarballs,

About 180 KB smaller...

> faster compilation in misc stages of code preprocessing

neglible change in speed...

> and last but not least lesser fuzz in diffs for people
> that do use editors which will strip such charcters by themselves.

This would be useful :-)

Cheers,
Paul
