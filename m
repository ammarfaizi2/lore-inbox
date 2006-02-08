Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWBHNjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWBHNjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 08:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWBHNjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 08:39:04 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:18124 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S965111AbWBHNjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 08:39:02 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Keith Owens'" <kaos@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff
References: <20060208035112.GM3524@stusta.de>
	<200602080552.k185q9g07813@unix-os.sc.intel.com>
	<20060208115946.GN3524@stusta.de>
From: Jes Sorensen <jes@sgi.com>
Date: 08 Feb 2006 08:38:57 -0500
In-Reply-To: <20060208115946.GN3524@stusta.de>
Message-ID: <yq0d5hym0lq.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:

Adrian> On Tue, Feb 07, 2006 at 09:52:09PM -0800, Chen, Kenneth W
Adrian> wrote:
>> But for the bit that this thread started, which disables
>> CONFIG_MCKINLEY for CONFIG_IA64_GENERIC, it is totally wrong and is
>> the "over my dead body" type of thing.

Adrian> My initial patch that started this thread was to remove all
Adrian> select's from CONFIG_IA64_GENERIC.

Adrian> Is this OK for you?

Adrian,

Not really, it helps a bit by selecting some things we know we need
for all GENERIC builds. True we can't make it bullet proof, but whats
there is better than removing it.

Jes
