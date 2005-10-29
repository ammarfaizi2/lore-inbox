Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbVJ2Ixn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbVJ2Ixn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 04:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVJ2Ixm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 04:53:42 -0400
Received: from rollcage.inittab.de ([194.150.191.146]:36370 "EHLO
	rollcage.inittab.de") by vger.kernel.org with ESMTP
	id S1750840AbVJ2Ixm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 04:53:42 -0400
Date: Sat, 29 Oct 2005 10:53:31 +0200
From: Norbert Tretkowski <norbert@tretkowski.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix alpha breakage
Message-ID: <20051029085331.GT4333@rollcage.inittab.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ivan Kokshaysky wrote:
> On Wed, Oct 26, 2005 at 11:06:23AM +0100, Al Viro wrote:
>> barrier.h uses barrier() in non-SMP case.  And doesn't include
>> compiler.h.
>
> Thanks, but better use <asm-alpha/compiler.h> because of potential
> problems with the "inline" redefinition.

Uhm, looks like this wasn't included in the final 2.6.14 release.

Norbert
