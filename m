Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275220AbTHMPM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275229AbTHMPM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:12:28 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:14829 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S275220AbTHMPM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:12:26 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 13 Aug 2003 17:12:24 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: marcelo@conectiva.com.br, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030813171224.2a13b97f.skraw@ithnet.com>
In-Reply-To: <20030813145940.GC26998@namesys.com>
References: <20030813125509.360c58fb.skraw@ithnet.com>
	<Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
	<20030813145940.GC26998@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 18:59:40 +0400
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Wed, Aug 13, 2003 at 11:53:09AM -0300, Marcelo Tosatti wrote:
> 
> > > Running SMP. So far no crash happened under ext3. 
> > > Still I see the tar-verification errors. None on the first day, 2 on the
> > > second
> 
> But tar verification errors are still bad, right?

Sure. Maybe both topics are unrelated. I can't tell.

> > > it still crashes, then ideas for patches will be welcome :-)
> > Great you tracked it down. Your previous traces almost always involved
> > reiserfs calls, which is another indicator that reiserfs is probably the
> > problem here.
> 
> reiserfs is just probably a bit more sensitive to memory corruptions.
> 
> > Chris, Oleg, it might be nice if you guys could look at previous oops
> > reports by Stephan. 
> 
> All of them looked like memory corruptions of unknown reason to me.

Well, that's exactly the reason why I am awaiting some more days of
up-and-running ext3. After how many days will you be convinced that a random
memory corruption should have hit the ext3 system that bad, that it should have
crashed?
I can add another week if you want me to, just tell me. The only thing I don't
want is that any doubts are left after testing ...
Still, current 2 days uptime is early stage, so let's give it some more time.

Regards,
Stephan
