Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbTLHQ6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbTLHQ4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:56:47 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:150 "HELO heather-ng.ithnet.com")
	by vger.kernel.org with SMTP id S265079AbTLHQzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:55:47 -0500
X-Sender-Authentication: net64
Date: Mon, 8 Dec 2003 17:55:43 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: mark@symonds.net, linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: 2.4.23 hard lock, 100% reproducible.
Message-Id: <20031208175543.6182c9a6.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0312081414150.1289-100000@logos.cnet>
References: <20031208165423.555c5783.skraw@ithnet.com>
	<Pine.LNX.4.44.0312081414150.1289-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003 14:15:27 -0200 (BRST)
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> 
> 
> On Mon, 8 Dec 2003, Stephan von Krawczynski wrote:
> 
> > On Mon, 8 Dec 2003 08:17:30 -0200 (BRST)
> > Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > 
> > > Mark,
> > > 
> > > Please try the latest BK tree. There was a known bug in the netfilter
> > > code which could cause the lockups. 
> > 
> > ...which leads me to the most-simple question: where can I find a changelog
> > for 2.4.23-bkX from www.kernel.org ? Inside ?
> 
> I believe there is nothing which generates 2.4.2x-bk changelogs right now.
> 
> It can be easily done.

Are you continuing to create pre-patches with readable changelogs on
kernel.org?

ONTOPIC: indeed it took me only few days to crash a 2.4.23 with heavy
net(filter) usage... Mine broke with "killing interrupt handler ..."


Regards,
Stephan
