Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUHJBAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUHJBAH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 21:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUHJBAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 21:00:06 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:33729 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267373AbUHJA7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:59:53 -0400
Subject: Re: 2.4.x vs 2.6.x: denormal handling and audio performance
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
In-Reply-To: <1092079195.16794.257.camel@cmn37.stanford.edu>
References: <1092079195.16794.257.camel@cmn37.stanford.edu>
Content-Type: text/plain
Message-Id: <1092099606.22613.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 21:00:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 15:19, Fernando Pablo Lopez-Lezcano wrote:
> Hi all, I've been trying to track weird behavior I'm experiencing when
> trying to use 2.6.x for "pro audio" applications and I think I have
> something to report (and some questions). 
> 
> First, the environment. I'm running the Jack low latency server on top
> of two different software installs on the same hardware, one is FC1 +
> 2.4.26 + low latency and preemption patches, the other is FC2 + 2.6.7
> rc2-mm2 + voluntary preemption O3. They are different hard disks swapped
> into the same P4 laptop. Both are running the same source code versions
> of all the audio programs that I use to test (but _not_ the same
> binaries, each one is built in the environment it runs on). 
> 

Have you tried using the exact same binaries under both 2.4 and 2.6? 
This would rule out a compiler issue.

In case anyone thinks this is an application bug, here are some links
pertaining to the P4 denormals-are-zero issue, these were at the bottom
of Fernando's post:

http://gcc.gnu.org/ml/gcc/2001-07/msg02162.html
http://lkml.org/lkml/2003/5/9/144

Lee




