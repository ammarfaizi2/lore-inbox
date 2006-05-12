Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWELMua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWELMua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWELMu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:50:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:15238 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751221AbWELMu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:50:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, discuss@x86-64.org
Subject: Re: Linux v2.6.17-rc4
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 12 May 2006 14:50:25 +0200
In-Reply-To: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
Message-ID: <p738xp776ge.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Ok, I've let the release time between -rc's slide a bit too much again, 
> but -rc4 is out there, and this is the time to hunker down for 2.6.17.
> 
> If you know of any regressions, please holler now, so that we don't miss 
> them. 

b44 on x86-64 is currently broken on systems with >1GB.  This affects
some people's laptops and is a regression. I have patches that I will
send soon, just waiting for feedback.

-Andi
