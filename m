Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbUCOVwc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbUCOVwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:52:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:5265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262807AbUCOVvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:51:31 -0500
Date: Mon, 15 Mar 2004 13:53:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@users.sourceforge.net
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Subject: Re: Remove pmdisk from kernel
Message-Id: <20040315135328.0f704933.akpm@osdl.org>
In-Reply-To: <1079379519.5350.20.camel@calvin.wpcb.org.au>
References: <20040315195440.GA1312@elf.ucw.cz>
	<20040315125357.3330c8c4.akpm@osdl.org>
	<20040315205752.GG258@elf.ucw.cz>
	<20040315132146.24f935c2.akpm@osdl.org>
	<1079379519.5350.20.camel@calvin.wpcb.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:
>
> On Tue, 2004-03-16 at 10:21, Andrew Morton wrote:
> > Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > I believe that you don't want swsusp2 in 2.6. It has hooks all over
> > > the place:
> > > ...
> > > 109 files changed, 3254 insertions(+), 624 deletions(-)
> > 
> > Ahem.  Agreed.
>
> Most of those changes are hooks to make the freezer for more reliable.
> That part of the functionality could be isolated from the bulk of
> suspend2. Would that make you happy?

It would make us happier.  Even happier would be a series of small, well
explained patches which bring swsusp into a final shape upon which more
than one developer actually agrees.

These wholesale replacements and deletions are an indication that something
has gone wrong with the development process here.
