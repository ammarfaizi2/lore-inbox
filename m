Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWD3InW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWD3InW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 04:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWD3InV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 04:43:21 -0400
Received: from mail.suse.de ([195.135.220.2]:33685 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751047AbWD3InV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 04:43:21 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.17-rc3] i386: fix broken FP exception handling
Date: Sun, 30 Apr 2006 10:42:59 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-stable <stable@kernel.org>
References: <200604291409_MC3-1-BE50-16AD@compuserve.com>
In-Reply-To: <200604291409_MC3-1-BE50-16AD@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604301042.59884.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 April 2006 20:07, Chuck Ebbert wrote:
> The FXSAVE information leak patch introduced a bug in FP exception
> handling: it clears FP exceptions only when there are already
> none outstanding.  Mikael Pettersson reported that causes problems
> with the Erlang runtime and has tested this fix.

Patch looks correct, thanks. All other cases (x86-64, 2.4) should
be already ok.

-Andi

