Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264122AbTE0Ulo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbTE0Uln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:41:43 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:53254 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264122AbTE0UlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:41:03 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 22:53:06 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <200305272224.22567.m.c.p@wolk-project.de> <20030527204519.GQ3767@dualathlon.random>
In-Reply-To: <20030527204519.GQ3767@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305272253.06726.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 22:45, Andrea Arcangeli wrote:

Hi Andrea,

> > I try to backport BIO and then AS for quite over 2 weeks now, but it
> > seems, at least for me, that it's an impossible mission ;(
> bio breaks all drivers, not a good idea to backport ;)
HAHAHAH. Another wasted 2 weeks in my life ;-)

But why does it brake all drivers? Could you please elaborate a bit?

> note that the anticipatory scheduler generates very bad results with the
> winmark. it certainly has merits but it has large downsides too.
hmm, I am not aware of it, or even I _was_ not aware of it till now.

> I would be also curious if you could compare anticipatory with CFQ. The
> CFQ was designed to provide the highest possible degree of fariness.
I'll can bench it, sure. I used CFQ before I switched to AS because I was 
curious about AS and as I didn't see a real difference in latency but AS gave 
me more throughput, I use AS from now on.

> I read it on l-k yesterday a few days ago, search emails from Linus with
> Jens somewhere in CC and you should find it.
Already found it :) thank you.

ciao, Marc

