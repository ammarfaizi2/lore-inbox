Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWHMP3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWHMP3C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 11:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWHMP3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 11:29:02 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21260 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751283AbWHMP3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 11:29:00 -0400
Date: Sun, 13 Aug 2006 17:28:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH for review] [123/145] i386: make fault notifier unconditional and export it
Message-ID: <20060813152859.GB3543@stusta.de>
References: <20060810935.775038000@suse.de> <20060810193722.8082B13B8E@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810193722.8082B13B8E@wotan.suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's needed for external debuggers and overhead is very small.
>...

We are currently trying to remove exports not used by any in-kernel 
code.

The patch description also lacks the name of what you call "external 
debuggers" (I assume the exports are not for a theoretical usage but for 
an already existing debugger?). There is no reason for keeping a patch 
description small.

Especially nowadays where people demand deprecation periods for removing 
exports without any in-kernel users there must be a _very_ good 
justification when adding such exports.

This is true for both the i386 and the x86_64 patches.

cu
Adrian

BTW1: The subject of this email is wrong (it's the x86_64 patch).
BTW2: Please use a valid To: header.

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

