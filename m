Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUETROe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUETROe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 13:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUETROe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 13:14:34 -0400
Received: from holomorphy.com ([207.189.100.168]:35715 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265124AbUETROd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 13:14:33 -0400
Date: Thu, 20 May 2004 10:14:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: struct page changes in 2.6.6
Message-ID: <20040520171429.GB2434@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
References: <20040520182152.45fb2ce7.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520182152.45fb2ce7.spyro@f2s.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 06:21:52PM +0100, Ian Molton wrote:
> Im trying to find the reason struct page lost its 'list' field -
> arm26 depended on it right up to 2.6.5.

grep -nr 'list' include/asm-arm26 arch/arm26 discovers 0 uses of
page->list.


-- wli
