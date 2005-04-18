Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVDREH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVDREH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 00:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVDREH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 00:07:27 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:49550 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261644AbVDREHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 00:07:22 -0400
X-ORBL: [67.124.119.21]
Date: Sun, 17 Apr 2005 21:07:18 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050418040718.GA31163@taniwha.stupidest.org>
References: <4263275A.2020405@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4263275A.2020405@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 12:19:54PM +0900, Takashi Ikebe wrote:

> This patch add function called "Live patching" which is defined on
> OSDL's carrier grade linux requiremnt definition to linux 2.6.11.7
> kernel.

I;m curious as to what people decided this was a necessary
requirement.

> The live patching allows process to patch on-line (without
> restarting process) on i386 and x86_64 architectures, by overwriting
> jump assembly code on entry point of functions which you want to
> fix, to patched functions.

Why can't you use ptrace for all this?
