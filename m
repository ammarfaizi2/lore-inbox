Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTJNCAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 22:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTJNCAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 22:00:24 -0400
Received: from holomorphy.com ([66.224.33.161]:1161 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262149AbTJNCAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 22:00:23 -0400
Date: Mon, 13 Oct 2003 19:03:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Darren Williams <dsw@gelato.unsw.edu.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM code question
Message-ID: <20031014020328.GM16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Darren Williams <dsw@gelato.unsw.edu.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031014013227.GA20406@cse.unsw.EDU.AU> <20031014014427.GL16158@holomorphy.com> <3F8B56E4.1060902@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8B56E4.1060902@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> It's an address calculation method. We subtract the address of the
>> start of the structure from the address of the member inside the
>> structure.


On Tue, Oct 14, 2003 at 11:52:36AM +1000, Nick Piggin wrote:
> AFAIKS the 0 is not part of the address calculation method though. It
> is only used in the argument to the typeof operator. I think 0 is used
> simply because its as good a place as any, right?

This is actually done differently from how I remember. Yes, 0 is useless.


-- wli
