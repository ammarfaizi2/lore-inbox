Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTEMM24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 08:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbTEMM24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 08:28:56 -0400
Received: from angband.namesys.com ([212.16.7.85]:18057 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261153AbTEMM2z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 08:28:55 -0400
Date: Tue, 13 May 2003 16:41:35 +0400
From: Oleg Drokin <green@namesys.com>
To: Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at inode.c:562!
Message-ID: <20030513124135.GA28238@namesys.com>
References: <1052823517.5022.3.camel@tor.trudheim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052823517.5022.3.camel@tor.trudheim.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, May 13, 2003 at 11:58:38AM +0100, Anders Karlsson wrote:

> Running kernel 2.4.21-rc2 and using reiserfs (built as module) on an IBM
> X31 laptop. I have hit a kernel bug (as per subject line).
> kernel BUG at inode.c:562!
> EIP:    0010:[<c01554da>]    Tainted: PF
> >>EIP; c01554da <clear_inode+1a/f0>   <=====

Hm, can you please try to reproduce without vmware modules ever being loaded?
What was the file that you tried to delete?

Thank you.

Bye,
    Oleg
