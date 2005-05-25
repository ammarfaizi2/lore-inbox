Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVEYGKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVEYGKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVEYGKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:10:34 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61361 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263926AbVEYGGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:06:24 -0400
Date: Wed, 25 May 2005 08:05:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Sven Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050525060551.GA5164@elte.hu>
References: <1116978244.19926.41.camel@dhcp153.mvista.com> <20050525001019.GA18048@nietzsche.lynx.com> <1116981913.19926.58.camel@dhcp153.mvista.com> <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <1116987976.2912.110.camel@mindpipe> <4293EFE8.1080106@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4293EFE8.1080106@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Lee Revell wrote:
> 
> > The IDE IRQ handler can in fact run for several ms, which people 
> > sure can detect.
> 
> Are you serious? Even at 10ms, the monitor refresh rate would have to 
> be over 100Hz for anyone to "notice" anything, right?... [...]

you are assuming direct observation. Sure, a human (normally) doesnt 
notice smaller than say 10-20 msec of lag. But, a human very much 
notices indirect effects of latencies, such as the nasty 'click' a 
soundcard produces if it overruns.

> What sort of numbers are you talking when you say several?

a couple of msecs easily even on fast boxes. Well over 10 msecs on 
slower boxes.

	Ingo
