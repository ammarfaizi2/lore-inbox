Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267977AbUIPLz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267977AbUIPLz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUIPLyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:54:23 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:6576 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267977AbUIPLwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:52:40 -0400
Subject: Re: [PATCH] Suspend2 merge: New exports.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: arjanv@redhat.com
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095334846.2698.13.camel@laptop.fenrus.com>
References: <1095333619.3327.189.camel@laptop.cunninghams>
	 <1095334846.2698.13.camel@laptop.fenrus.com>
Content-Type: text/plain
Message-Id: <1095335648.4883.230.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 21:54:09 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-09-16 at 21:40, Arjan van de Ven wrote:
> On Thu, 2004-09-16 at 13:20, Nigel Cunningham wrote:
> 
> >  
> > +EXPORT_SYMBOL(tainted);
> 
> uhhhhh why do you need this in a module ?????
> 
> most of these exports look REALLY fishy to me.

I'm marking the kernel as tainted when we've suspended. It could
probably be dropped but I was erring on the side of paranoia.

As to the others, I'll be happy to explain how they're used and drop
them if necessary/possible. I agree about a couple. The keyboard sound
one, for example, slipped past my purge of some
report-progress-while-beeping code I inherited.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

