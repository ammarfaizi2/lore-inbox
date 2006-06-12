Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWFLSOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWFLSOq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWFLSOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:14:46 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48556 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751622AbWFLSOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:14:45 -0400
Subject: Re: broken local_t on i386
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606121906.28692.ak@suse.de>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	 <200606121848.05438.ak@suse.de>
	 <Pine.LNX.4.64.0606120950280.19309@schroedinger.engr.sgi.com>
	 <200606121906.28692.ak@suse.de>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 14:14:42 -0400
Message-Id: <1150136082.3062.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 19:06 +0200, Andi Kleen wrote:
> Also on non preemptive kernels - which are the majority - it's a
> single instruction on x86. I guess preempt users can live with a bit
> more overhead ...  

I don't think that's the case anymore.  Ubuntu is the #1 distro and the
latest release ships with preemption enabled.

Lee

