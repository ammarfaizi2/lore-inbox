Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbVJ1Q2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVJ1Q2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbVJ1Q2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:28:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7853 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030200AbVJ1Q2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:28:11 -0400
Date: Fri, 28 Oct 2005 12:28:06 -0400
From: Dave Jones <davej@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel D945GNT crashes with AGP enabled
Message-ID: <20051028162806.GA4340@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
References: <1130506715.5345.7.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130506715.5345.7.camel@blade>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 03:38:35PM +0200, Marcel Holtmann wrote:
 > The problematic part is the Intel AGP module (intel_agp), because if I
 > don't compile it the system works fine. There is an oops coming, but so
 > far I wasn't able to get it out. Does anyone have seen this problem
 > before and have some patches for me to try? Otherwise I need to try to
 > get this oops message.

You never mentioned what kernel you're running.
If it's a recent -mm, there's an AGP optimisation patch to do less
frequent TLB flushes, which may be worth backing out.

If you're running mainline, I'm puzzled.
It'd be useful to see that oops.

		Dave

