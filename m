Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUA3VPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 16:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbUA3VPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 16:15:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2887 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263942AbUA3VPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 16:15:30 -0500
To: David Weinehall <tao@acc.umu.se>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
References: <20040129193727.GJ21888@waste.org>
	<20040129201556.GK16675@khan.acc.umu.se>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Jan 2004 14:08:25 -0700
In-Reply-To: <20040129201556.GK16675@khan.acc.umu.se>
Message-ID: <m1n085xhyu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall <tao@acc.umu.se> writes:

> On Thu, Jan 29, 2004 at 01:37:28PM -0600, Matt Mackall wrote:
> > I've been fiddling with cleaning up some old code here and suggest the
> > following to make Lindent match actual practice more closely. This does:
> > 
> > a) (no -psl)
> > 
> > void *foo(void) {
> > 
> >  instead of
> > 
> > void *
> > foo(void) {
> > 
> > b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
> 
> I can't really see the logic in this, though I know a lot of people do
> it.  I try to stay consistent, thus I do:

If consistency was good in a language we would all be using
an RPL or s-expr based language.  Communication is clearer
with redundant information.  Making special cases of common
cases is a good thing.

Eric
