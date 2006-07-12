Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWGLWd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWGLWd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWGLWd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:33:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:12934 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932132AbWGLWd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:33:27 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Date: Thu, 13 Jul 2006 00:33:16 +0200
User-Agent: KMail/1.9.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
References: <20060630014050.GI19712@stusta.de> <200607130006.12705.ak@suse.de> <20060712221910.GA12905@elte.hu>
In-Reply-To: <20060712221910.GA12905@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607130033.16555.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I can put in a patch into my tree for the next merge to disable the 
> > TSC disable code on i386 too like I did earlier for x86-64.
> 
> please do.

Hmm, with the new thread test as it was pointed out it can be indeed made zero 
cost for the common case. Perhaps that's not needed then.

-Andi
