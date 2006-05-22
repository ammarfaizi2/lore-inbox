Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWEVXLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWEVXLk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 19:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWEVXLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 19:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:45274 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751291AbWEVXLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 19:11:39 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [stable][patch] x86_64: fix number of ia32 syscalls
Date: Tue, 23 May 2006 01:11:17 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Dave Jones <davej@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       linux-stable <stable@kernel.org>
References: <200605221701_MC3-1-C081-B4B3@compuserve.com>
In-Reply-To: <200605221701_MC3-1-C081-B4B3@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605230111.18121.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 22:59, Chuck Ebbert wrote:
> Recent discussions about whether to print a message about unimplemented
> ia32 syscalls on x86_64 have missed the real bug: the number of ia32
> syscalls is wrong in 2.6.16.  Fixing that kills the message.

There is already a slightly different patch for this in the FF tree.

-Andi
