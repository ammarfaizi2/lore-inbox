Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272220AbTHNGSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 02:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272168AbTHNGSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 02:18:48 -0400
Received: from holomorphy.com ([66.224.33.161]:40120 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272220AbTHNGSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 02:18:41 -0400
Date: Wed, 13 Aug 2003 23:19:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O14int
Message-ID: <20030814061953.GL32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308090149.25688.kernel@kolivas.org> <200308120033.32391.kernel@kolivas.org> <1060615179.13255.133.camel@workshop.saharacpt.lan> <200308121545.52042.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308121545.52042.kernel@kolivas.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003 01:19, Martin Schlemmer wrote:
>> Normal run of things there is many times 1-3 'make -j6s' running.
>> Yes, sure, for on of them you prob should use -j4, but hey its
>> in the head, right =).  No, it is not kernels, it is a variety

On Wed, Aug 13, 2003 at 04:48:18PM +1000, Con Kolivas wrote:
> Actually in benchmarking I've found no increase in speed with more than one 
> job per cpu but it's up to you of course.

I found some strange SMP artifacts that seemed to show a dromedary-like
throughput curve with respect to tasks, with one peak at 4 tasks/cpu and
another peak at 16 tasks/cpu on a 16x box (for kernel compiles).

But I don't consider that evidence of anything to do something about.


-- wli
