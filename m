Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbUC2EJr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 23:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUC2EJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 23:09:47 -0500
Received: from zero.aec.at ([193.170.194.10]:62728 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262602AbUC2EJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 23:09:46 -0500
To: Andreas Hartmann <andihartmann@freenet.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Very poor performance with 2.6.4
References: <1EOM0-3oS-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 29 Mar 2004 00:47:08 +0200
In-Reply-To: <1EOM0-3oS-17@gated-at.bofh.it> (Andreas Hartmann's message of
 "Sun, 28 Mar 2004 22:10:32 +0200")
Message-ID: <m3n060egib.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann <andihartmann@freenet.de> writes:
>
> Now, I switched off preemption. But the performance isn't much better:
> 8.8% (9.3% with preemption) more real-time compared to 2.4.25 and 28%
> (32.9% with preepmtion) more system-time.

Install oprofile and do a profile run on the 2.6 kernel. This should
tell you where the system time is wasted. Post the results on this
list.

-Andi



