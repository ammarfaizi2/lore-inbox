Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbTH1Ti6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTH1Ti6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:38:58 -0400
Received: from holomorphy.com ([66.224.33.161]:40132 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264260AbTH1Tiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:38:55 -0400
Date: Thu, 28 Aug 2003 12:40:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make voyager work again after the cpumask_t changes
Message-ID: <20030828194006.GJ4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
	linux-kernel@vger.kernel.org
References: <1062097375.1952.41.camel@mulgrave> <20030828121016.2c0e2716.akpm@osdl.org> <20030828193123.GI4306@holomorphy.com> <20030828122006.0c9b4aa4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828122006.0c9b4aa4.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> I'm not convinced it's worth it; AIUI there are architectural limits to
>> Voyager that prevent it from ever supporting > 32x in hardware,

On Thu, Aug 28, 2003 at 12:20:06PM -0700, Andrew Morton wrote:
> Sure.  But we want a kernel which was compiled with NR_CPUS>32 to still
> boot and run correctly on voyager.
> Yes, the code as-is will happen to work, but dtrt and all that.

Okay, I'll send in the obvious cleanup and run it by jejb first.


-- wli
