Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVAEFW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVAEFW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 00:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVAEFW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 00:22:57 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:60600 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262244AbVAEFWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 00:22:55 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>
In-Reply-To: <41DB4476.8080400@domdv.de>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org>
	 <1104865034.8346.4.camel@krustophenia.net>  <41DB4476.8080400@domdv.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104898693.24187.162.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 04:18:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-05 at 01:35, Andreas Steinmetz wrote:
> Let me remind you all that according to lkml history hch has always been 
> biased and objecting to anything related to lsm. Nobody can take hch's 
> opinion here as objective. I would even go so far that when things are 
> related to lsm(s) he's just tro...

Oh I don't think so. Everyone thinks Christoph has it in for their
project (me included quite often). He's just blessed with a lot of taste
and determination to enforce it, and cursed (or perhaps blessed) with
the ability to explain bluntly and clearly his opinion.

gid hacks are not a good long term plan.

Can we use capabilities, if not - why not and how do we fix it so we can
do the job right. Do we need some more capability bits that are
implicitly inherited and not touched by setuidness ?


