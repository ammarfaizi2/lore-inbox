Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTJ1TTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 14:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTJ1TTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 14:19:23 -0500
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:7833
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S261538AbTJ1TTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 14:19:22 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday resolution seriously degraded in test9
References: <LphK.2Dl.15@gated-at.bofh.it> <Lq47.3Go.11@gated-at.bofh.it> <LqGL.4zF.11@gated-at.bofh.it> <LAPN.1dU.11@gated-at.bofh.it> <LGLz.1h2.5@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 28 Oct 2003 11:19:21 -0800
In-Reply-To: <LGLz.1h2.5@gated-at.bofh.it>
Message-ID: <ug8yn541c6.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 28 Oct 2003 19:30:13 +0100, Stephen Hemminger <shemminger@osdl.org> said:

  Stephen> This should work better. Patch against 2.6.0-test9

Why not use the time-interpolator interface defined in timex.h?  It
should handle such things without any special hacks.

	--david
