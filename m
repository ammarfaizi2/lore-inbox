Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbTIKRvl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbTIKRvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:51:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:55697 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261445AbTIKRsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:48:50 -0400
Date: Thu, 11 Sep 2003 18:48:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030911174839.GM29532@mail.jlokier.co.uk>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com> <20030911012708.GD3134@wotan.suse.de> <20030911165845.GE29532@mail.jlokier.co.uk> <20030911190516.64128fe9.ak@suse.de> <20030911173245.GJ29532@mail.jlokier.co.uk> <20030911193954.63724a82.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911193954.63724a82.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> signal exception path is thousands of cycles, we're talking about tens
> of cycles here.

<hand-waving>

Tens vs thousands == percentage points.

Isn't it about 20 cycles per mispredicted branch on a P4?

Five of those and we're talking several percent slowdown, ridiculous
as it seems.

</hand-waving>

-- Jamie
