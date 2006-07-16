Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWGPVZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWGPVZl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 17:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWGPVZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 17:25:41 -0400
Received: from mail.suse.de ([195.135.220.2]:956 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751274AbWGPVZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 17:25:40 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH for 2.6.18-rc2] [2/8] i386/x86-64: Don't randomize stack top when no randomization personality is set
Date: Sun, 16 Jul 2006 23:27:12 +0200
User-Agent: KMail/1.9.1
Cc: torvalds@osdl.org, akpm@osdl.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>
References: <44ba2f8d.0hsur33TTkK+bbJl%ak@suse.de> <200607162314.07764.ak@suse.de> <20060716211126.GA2880@elte.hu>
In-Reply-To: <20060716211126.GA2880@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607162327.12824.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> yeah. There's one security issue: the 'dont randomize' flag must be
> cleared when we cross a protection domain. When for example suid-ing in
> exec().

Good point.

-Andi
