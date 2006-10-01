Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWJAL5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWJAL5N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWJAL5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:57:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:2245 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932099AbWJAL5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:57:12 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: x86 BUG bug
Date: Sun, 1 Oct 2006 13:56:47 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <451FA997.9050000@garzik.org>
In-Reply-To: <451FA997.9050000@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610011356.47750.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Being rusty on the gcc asm syntax -- does an inline asm statement permit 
> 'noreturn'? -- I figured it would be best just to report this, rather 
> than create a patch myself.

It doesn't AFAIK. It might be possible with an inline function
though with a wrapper macro for __FUNCTION__

-Andi
