Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268464AbUJJUTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268464AbUJJUTW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 16:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268465AbUJJUTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 16:19:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35500 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268464AbUJJUTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 16:19:14 -0400
Date: Sun, 10 Oct 2004 22:20:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041010202019.GA15483@elte.hu>
References: <41677E4D.1030403@mvista.com> <4169293B.3020502@comcast.net> <1097429214.1427.14.camel@krustophenia.net> <4169833C.4070006@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4169833C.4070006@comcast.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* John Richard Moser <nigelenki@comcast.net> wrote:

> | The VP patches currently work on x86, x64, amd64, and ppc AFAIK.  As
> | stated in the docs, the MontaVista stuff is x86 only right now.
> 
> Is there a stable amd64 voluntary pre-empt patch for 2.6.7?  I'm using
> PaX so I can't go up until the author catches up to the new VM changes
> introduced in 2.6.8+.

nope, latest -VP is against 2.6.9-rc3-mm3-ish kernels. Since half of -VP
is in -mm already in various forms of patches it would be quite hard to
extract all of that even against a vanilla 2.6.9-rc3 kernel - let alone
against 2.6.7.

	Ingo
