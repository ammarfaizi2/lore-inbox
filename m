Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbUCLCgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 21:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUCLCgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 21:36:15 -0500
Received: from [66.35.79.110] ([66.35.79.110]:18060 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261916AbUCLCf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 21:35:58 -0500
Date: Thu, 11 Mar 2004 18:35:51 -0800
From: Tim Hockin <thockin@hockin.org>
To: Eric Brower <ebrower@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethtool.h should use userspace-accessible types
Message-ID: <20040312023551.GA25331@hockin.org>
References: <40511868.4060109@usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40511868.4060109@usa.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 05:54:48PM -0800, Eric Brower wrote:
> Attached is a patch to 2.4's ethtool.h to use appropriate, 
> userspace-accessible data types (__u8 and friends, rather than u8 and 
> friends).

if we *know* the width of them, why don't we just use C99 standard types in
*both* places?  I've never quite grokked why we need u8 and __u8 and all the
variants, when we now have uint8_t.  I mean, at least it's standardized.

Anyone have a logical answer?
