Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUFKKsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUFKKsj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 06:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUFKKsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 06:48:39 -0400
Received: from zero.aec.at ([193.170.194.10]:1029 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263802AbUFKKsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 06:48:37 -0400
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
References: <2576k-4hW-13@gated-at.bofh.it> <25LZK-88C-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 11 Jun 2004 12:48:33 +0200
In-Reply-To: <25LZK-88C-17@gated-at.bofh.it> (Paul Jackson's message of
 "Fri, 11 Jun 2004 06:40:08 +0200")
Message-ID: <m3r7sm5q0u.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:
>
> Uninlining find_first_bit() reduces my i386 kernel text size by 1336 bytes.

Sounds attractive. I planned to uninline them for some time anyways
on x86-64, but that number makes it even more a good idea.

-Andi

