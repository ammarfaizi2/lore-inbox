Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTFRWwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265598AbTFRWwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:52:35 -0400
Received: from ns.suse.de ([213.95.15.193]:38925 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265591AbTFRWw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:52:29 -0400
Date: Thu, 19 Jun 2003 01:06:26 +0200
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.72] Oops on x86_64 running 32-bit code
Message-ID: <20030618230626.GA27063@wotan.suse.de>
References: <1055976017.25153.74.camel@serpentine.internal.keyresearch.com> <20030618224516.GF3543@wotan.suse.de> <1055976671.25153.80.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055976671.25153.80.camel@serpentine.internal.keyresearch.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 03:51:11PM -0700, Bryan O'Sullivan wrote:
> This time, there are no syslog errors or other reports to indicate
> what's up.  I can't strace it to see where it's dying, because 64-bit
> strace won't handle 32-bit code.

If it's a SuSE system you can use strace32, otherwise just copy
over a 32bit strace binary from some i386 box.

-Andi
