Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVEYGNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVEYGNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVEYGKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:10:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27269 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262293AbVEYGKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:10:03 -0400
Date: Wed, 25 May 2005 08:09:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       hch@infradead.org, linux-kernel@vger.kernel.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-ID: <20050525060936.GB5164@elte.hu>
References: <20050524090240.GA13129@elte.hu> <4292F074.7010104@yahoo.com.au> <1116957953.31174.37.camel@dhcp153.mvista.com> <20050524224157.GA17781@nietzsche.lynx.com> <1116978244.19926.41.camel@dhcp153.mvista.com> <20050525001019.GA18048@nietzsche.lynx.com> <1116981913.19926.58.camel@dhcp153.mvista.com> <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524184351.47d1a147.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> (That being said, it's already a mighty task to decrypt your way 
> through the maze-like implementation of spin_lock(), lock_kernel(), 
> smp_processor_id() etc, etc.  I really do wish there was some way we 
> could clean up/simplify that stuff before getting in and adding more 
> source-level complexity).

yes, that's next on my list, and it's completely independent of 
PREEMPT_RT, as 'the maze of spinlock APIs' already exists in the current 
kernel. (PREEMPT_RT only makes the problem worse) But dont expect big 
wonders.

	Ingo
