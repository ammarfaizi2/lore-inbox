Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVCAAsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVCAAsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVCAApV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:45:21 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:78
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261157AbVCAAoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:44:54 -0500
Date: Tue, 1 Mar 2005 01:44:49 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050301004449.GV8880@opteron.random>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050224215136.GK8651@stusta.de> <20050224224134.GE20715@opteron.random> <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301003247.GY4021@stusta.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 01:32:47AM +0100, Adrian Bunk wrote:
> If you want to use Cpushare, you know that you have to enable seccomp.

Oh yeah, I know it, you know it, but not everyone will know it while
configuring the kernel, infact I doubt they'll even know what Cpushare
is about while they configure the kernel ;). And I doubt they should be
required to know all those details in order to make that choice, and my
point is that seccomp is low overhead enough that everyone can enable it
if they're unsure, just in case. I'm just trying to explain why I
recommend it to Y by default "if unsure".
