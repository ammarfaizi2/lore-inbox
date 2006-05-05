Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWEESLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWEESLY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 14:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWEESLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 14:11:24 -0400
Received: from ns1.suse.de ([195.135.220.2]:7315 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751185AbWEESLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 14:11:24 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugs aren't features: X86_FEATURE_FXSAVE_LEAK
References: <445B7EF0.6090708@zytor.com>
From: Andi Kleen <ak@suse.de>
Date: 05 May 2006 20:11:22 +0200
In-Reply-To: <445B7EF0.6090708@zytor.com>
Message-ID: <p733bfo5ol1.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> The recent fix for the AMD FXSAVE information leak had a problematic
> side effect.  It introduced an entry in the x86 features vector which
> is a bug, not a feature.

It's a non issue because it affects all AMD CPUs (except K5/K6).
You'll never find a system where only some CPUs have this problem.

-Andi
