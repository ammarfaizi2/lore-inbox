Return-Path: <linux-kernel-owner+w=401wt.eu-S1752871AbWLSGqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbWLSGqR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbWLSGqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:46:17 -0500
Received: from kanga.kvack.org ([66.96.29.28]:46429 "EHLO kanga.kvack.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbWLSGqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:46:16 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 01:46:16 EST
Date: Tue, 19 Dec 2006 01:39:55 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: David Wragg <david@wragg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] procfs: export context switch counts in /proc/*/stat
Message-ID: <20061219063955.GN1104@kvack.org>
References: <87zm9k228f.fsf@wragg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zm9k228f.fsf@wragg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 11:50:08PM +0000, David Wragg wrote:
> This patch (against 2.6.19/2.6.19.1) adds the four context switch
> values (voluntary context switches, involuntary context switches, and
> the same values accumulated from terminated child processes) to the
> end of /proc/*/stat, similarly to min_flt, maj_flt and the time used
> values.

Please put these into new files, as the stat files in /proc are 
horribly overloaded and have always been somewhat problematic 
when it comes to changing how things are reported due to internal 
changes to the kernel.  Cheers,

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
