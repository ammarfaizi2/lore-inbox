Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbUKNGYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbUKNGYU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 01:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUKNGYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 01:24:19 -0500
Received: from holomorphy.com ([207.189.100.168]:15785 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261249AbUKNGXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 01:23:50 -0500
Date: Sat, 13 Nov 2004 22:23:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: Re: Parenthize nth_page() macro arg, in linux/mm.h.
Message-ID: <20041114062346.GG3217@holomorphy.com>
References: <200411140517.iAE5HOqM010399@hera.kernel.org> <20041114061016.GF3217@holomorphy.com> <20041114061855.GA11738@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114061855.GA11738@parcelfarce.linux.theplanet.co.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 10:10:16PM -0800, William Lee Irwin III wrote:
>> Okay, #1 the ((page)) thing should be unnecessary. If it is necessary,
>> arch code is broken, which leads to #2: this came about because alpha
>> wasn't parenthesizing its args in pfn_to_page(); where did the fix for
>> that go?

On Sun, Nov 14, 2004 at 06:18:56AM +0000, Al Viro wrote:
> In my tree; I'm preparing -bk23-bird1 right now, will post in an hour or so.

Sounds good to me. Thanks for clearing up my misunderstanding.


-- wli
