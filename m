Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268389AbUHYTj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268389AbUHYTj1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUHYTj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:39:27 -0400
Received: from holomorphy.com ([207.189.100.168]:63886 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268389AbUHYTj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:39:26 -0400
Date: Wed, 25 Aug 2004 12:39:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [0/4] remove signal.h from sched.h
Message-ID: <20040825193921.GC2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com> <20040819150632.GP11200@holomorphy.com> <20040825180138.GA2793@holomorphy.com> <20040825180342.GB2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825180342.GB2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 11:03:42AM -0700, William Lee Irwin III wrote:
> This patch moves all user bits from linux/sched.h to linux/user.h and
> sweeps all files fiddling with users.

This series removes the dependency of sched.h on signal.h
Atop the just-posted user bits atop 2.6.8.1-mm4.


-- wli
