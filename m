Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUGKKJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUGKKJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUGKKJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:09:10 -0400
Received: from zero.aec.at ([193.170.194.10]:1802 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266547AbUGKKJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:09:09 -0400
To: Ingo Molnar <mingo@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
References: <2giKE-67F-1@gated-at.bofh.it> <2gIc8-6pd-29@gated-at.bofh.it>
	<2gJ8a-72b-11@gated-at.bofh.it> <2gJhY-776-21@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 11 Jul 2004 12:09:05 +0200
In-Reply-To: <2gJhY-776-21@gated-at.bofh.it> (Ingo Molnar's message of "Sun,
 11 Jul 2004 12:00:14 +0200")
Message-ID: <m31xjiam9q.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@redhat.com> writes:
>  		}
> +#ifdef __i386_

Won't do on x86-64.

-Andi


