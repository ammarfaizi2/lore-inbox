Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTJMKwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTJMKwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:52:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:17823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261328AbTJMKwD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 06:52:03 -0400
Date: Mon, 13 Oct 2003 03:55:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: davidm@hpl.hp.com, jbarnes@sgi.com, pfg@sgi.com,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: [PATCH] Altix I/O code cleanup
Message-Id: <20031013035512.3859067d.akpm@osdl.org>
In-Reply-To: <20031013095824.B25495@infradead.org>
References: <3F872984.7877D382@sgi.com>
	<20031010215153.GA5328@sgi.com>
	<16263.14277.278807.472247@napali.hpl.hp.com>
	<20031013095824.B25495@infradead.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Oct 10, 2003 at 03:50:45PM -0700, David Mosberger wrote:
> > >>>>> On Fri, 10 Oct 2003 14:51:53 -0700, jbarnes@sgi.com (Jesse Barnes) said:
> > 
> >   Jesse> David, please apply this set of patches from Pat.
> > 
> > Unfortunately, the 2.6 tree is closed for cleanups.  I would _like_ to
> > see the patch applied, though.  Perhaps you could talk to Andrew and
> > see if you can get an exception?
> 
> Sounds strange to apply this rule for a particular årchitectured that
> just managed to compile again on 2.6 and has a huge backlog of cleanups
> and restructuring now...

Well there are two reasons for discouraging cleanups.  The first is of
course that they can destabilise things.  But the other is that we want as
many developers as possible (Hi, Jesse) concentrating on stabilisation.

I hereby introduce the "bugzilla tax".  The cost of each cleanup is two
fixes for open bugzilla entries.

But if David really wants this change, and ongoing stabilisation work will
be based on top of it then yes, it probably should go in after good
testing.

