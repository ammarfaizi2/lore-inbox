Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268445AbUILFB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbUILFB6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUILFB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:01:58 -0400
Received: from holomorphy.com ([207.189.100.168]:12163 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268445AbUILFAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:00:33 -0400
Date: Sat, 11 Sep 2004 22:00:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] Kill CONFIG_4KSTACKS
Message-ID: <20040912050030.GD2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
	Arjan van de Ven <arjanv@redhat.com>
References: <20040911204125.GA26179@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911204125.GA26179@taniwha.stupidest.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 01:41:25PM -0700, Chris Wedgwood wrote:
> http://linux.bkbits.net:8080/linux-2.5/cset@407af9a3SmWwuO0CEQwLmAZoLXAcCA
> seems to indicate 8K stacks are deprecated.  This removes the option
> completely so were now use 4k-process + 4k-irq stacks all the time.
> Probably a bit premature...

Another, distinct patch to add warnings or errors for all versions of
gcc prior to the stack fix commit might be helpful.


-- wli
