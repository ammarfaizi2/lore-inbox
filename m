Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264179AbTH1Sbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264187AbTH1Sbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:31:42 -0400
Received: from holomorphy.com ([66.224.33.161]:9412 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264179AbTH1Sbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:31:41 -0400
Date: Thu, 28 Aug 2003 11:32:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bad definition of cpus_complement
Message-ID: <20030828183228.GH4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joe Korty <joe.korty@ccur.com>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030828155451.GA16156@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828155451.GA16156@tsunami.ccur.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 11:54:52AM -0400, Joe Korty wrote:
> One of the definitions of cpus_complement is broke.  Also, cpus_complement is
> the only cpus_* definition which operates in-place rather than in (dst,src)
> form.  I will submit a patch to convert if there is interest.

The definition is fine (see other responses), but the inconsistent
argument convention might be worth shoring up to match the others.


-- wli
