Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbUFFFwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUFFFwa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 01:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUFFFwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 01:52:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40398 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262909AbUFFFw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 01:52:29 -0400
Date: Sun, 6 Jun 2004 07:53:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable scheduler debugging
Message-ID: <20040606055336.GA15350@elte.hu>
References: <20040606033238.4e7d72fc.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040606033238.4e7d72fc.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> The domain scheduler spews out a lot of information at boot up, but it
> looks mostly redundant because it's just a transformation of what is
> in /proc/cpuinfo anyways. Also it is well tested now. Disable it.

i'd rather keep it some more, there are still open issues and if there's
a boot failure or early crash it makes it easier for us to see the
actual domain setup. Also, the messages are KERN_DEBUG.

	Ingo
