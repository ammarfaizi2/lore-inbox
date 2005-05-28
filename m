Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVE1LRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVE1LRu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 07:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVE1LRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 07:17:50 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:63841 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262686AbVE1LRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 07:17:48 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: David Howells <dhowells@redhat.com>
Subject: Re: [patch 4/8] irq code: Add coherence test for PREEMPT_ACTIVE
Date: Sat, 28 May 2005 13:19:51 +0200
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org
References: <200505270306.09425.blaisorblade@yahoo.it> <20050527003843.433BA1AEE88@zion.home.lan> <14927.1117200829@redhat.com>
In-Reply-To: <14927.1117200829@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281319.52153.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 15:33, David Howells wrote:
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> > Ok, a grep shows that possible culprits (i.e. giving success to
> > grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as
> > PREEMPT_ACTIVE, as given by grep PREEMPT_ACTIVE
> > include/asm-*/thread_info.h) are (at a first glance): frv, sh, sh64.
>
> For FRV that's simply because it got copied from the parent arch along with
> other stuff. Feel free to move it... Do you want me to make you up a patch
> to do so?
Sorry but fix that yourself, otherwise you get a chance I'll forget since I'm 
quite busy.

Thanks a lot for attention.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com
