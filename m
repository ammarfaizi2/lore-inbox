Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVKOPco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVKOPco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVKOPco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:32:44 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:57256 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932541AbVKOPcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:32:43 -0500
Date: Tue, 15 Nov 2005 16:32:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Softlockup detected with linux-2.6.14-rt6
Message-ID: <20051115153257.GA9727@elte.hu>
References: <4378B48E.6010006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4378B48E.6010006@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Luca Falavigna <dktrkranz@gmail.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I found this softlockup bug involving arts daemon using a
> linux-2.6.14-rt6 kernel (with "Complete Preemption" and "Detect Soft
> Lockups" compiled in).
> This bug does not happen everytime: I was able to reproduce it only
> three times in a week. [...]

does this happen with -rt13 too? I have fixed a softlockup 
false-positive in it.

	Ingo
