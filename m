Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVCIRd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVCIRd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVCIRd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:33:27 -0500
Received: from one.firstfloor.org ([213.235.205.2]:26023 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262100AbVCIRYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:24:13 -0500
To: blaisorblade@yahoo.it
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch 1/1] x86-64: forgot asmlinkage on sys_mmap
References: <20050305190005.0943C4B47@zion>
From: Andi Kleen <ak@muc.de>
Date: Wed, 09 Mar 2005 18:24:07 +0100
In-Reply-To: <20050305190005.0943C4B47@zion> (blaisorblade@yahoo.it's
 message of "Sat, 05 Mar 2005 20:00:04 +0100")
Message-ID: <m1br9swx54.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it writes:

> CC: Andi Kleen <ak@suse.de>
>
> I think it should be there, please check better.

It doesn't matter. asmlinkage is a nop on x86-64.

-Andi
