Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263319AbVGAXv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbVGAXv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVGAXv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:51:58 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:9366 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263319AbVGAXvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:51:54 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 1/2] UML - skas0 - separate kernel address space on stock hosts
Date: Sat, 2 Jul 2005 01:57:36 +0200
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org,
       "blaisorblade@yahoo.it" <blaisorblade_spam@yahoo.it>
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org> <20050701145802.5cebabd2.akpm@osdl.org>
In-Reply-To: <20050701145802.5cebabd2.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507020157.37593.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 July 2005 23:58, Andrew Morton wrote:
> Jeff Dike <jdike@addtoit.com> wrote:
> > This patch implements something very close to skas mode for hosts
> > which don't support skas - I'm calling this skas0.
>
> I note that this patch assumes that
> uml-kill-some-useless-vmalloc-tlb-flushing.patch is applied.
You're fixing the conflict anyway since it's little, correct?
> AFAIK that patch is still in limbo due to objections from Paolo.  Can we
> sort that out please?
Ok, I'm going to test that out in the offending configuration. If that works, 
then Jeff will explain us why the same (rephrased) patch didn't work in 2.4 
and works in 2.6. When we have an explaination about that, I'll be very happy 
about merging the patch.

For myself, I don't even know why it didn't work in 2.4, I 
hadn't the knowledge and haven't the time.

People got breakage and when searching for it that looked the most invasive 
change, so I suggested removing and tests confirmed that.

However, for now it seems that I can't reproduce anyway the iptables crash, 
and even Jeff did some testing... so it seems it's ok.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
