Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUIPVno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUIPVno (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUIPVno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:43:44 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:51710 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S266561AbUIPVnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:43:43 -0400
Date: Thu, 16 Sep 2004 23:43:40 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: nproc: So?
Message-ID: <20040916214340.GA3548@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908184028.GA10840@k3.hellgate.ch>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have received some constructive criticism and suggestions, but I didn't
see any comments on the desirability of nproc in mainline. Initially meant
to be a proof-of-concept, nproc has become an interface that is much
cleaner and faster than procfs can ever hope to be (it takes some reading
of procps or libgtop code to appreciate the complexity that is /proc file
parsing today), and every change in /proc files widens the gap. I presented
source code, benchmarks, and design documentation to substantiate my
claims; I can post the user-space code somewhere if there's interest.

So I'm wondering if everybody's waiting for me to answer some important
question I overlooked, or if there is a general sentiment that this
project is not worth pursuing.

Roger
