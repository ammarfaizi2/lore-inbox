Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUF1USg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUF1USg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUF1USe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:18:34 -0400
Received: from holomorphy.com ([207.189.100.168]:41123 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265196AbUF1US0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:18:26 -0400
Date: Mon, 28 Jun 2004 13:18:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Brian <bmg300@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel VM bug?
Message-ID: <20040628201822.GW21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Brian <bmg300@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20040628025832.GM21066@holomorphy.com> <Pine.LNX.4.44.0406281342480.13228-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406281342480.13228-100000@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 02:01:29PM +0100, Hugh Dickins wrote:
> I'm not sure if I'm niggling over terminology, or pointing out a
> significant misunderstanding: but /proc/sys/vm/overcommit_memory 0
> (indeed the default) is not what I call strict non-overcommit: that's 2.
> All settings (0, 1, 2) maintain the Committed_AS count shown in
> /proc/meminfo; but only /proc/sys/vm/overcommit_memory 2 totals and
> limits reservations using it.  1 imposes no limit.  0 checks that the
> particular "reservation" could plausibly be made available now, but
> without considering the total: so allows any number of concurrent
> maximum reservations - traditional relaxed Linux behaviour, not strict.
> (2 came along much later, yes the naming and numbering are both horrid.)

I'm not sure if the numbers changed or something else went wrong. Not
encouraging to hear this behaved differently from my expectations
without my noticing.


-- wli
