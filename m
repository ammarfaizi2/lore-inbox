Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWGEWHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWGEWHh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 18:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWGEWHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 18:07:37 -0400
Received: from xenotime.net ([66.160.160.81]:39343 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965020AbWGEWHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 18:07:36 -0400
Date: Wed, 5 Jul 2006 15:10:21 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-Id: <20060705151021.26f013c4.rdunlap@xenotime.net>
In-Reply-To: <20060705220009.GB32040@elte.hu>
References: <20060705113054.GA30919@elte.hu>
	<20060705114630.GA3134@elte.hu>
	<20060705101059.66a762bf.akpm@osdl.org>
	<20060705193551.GA13070@elte.hu>
	<20060705131824.52fa20ec.akpm@osdl.org>
	<Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	<20060705204727.GA16615@elte.hu>
	<Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	<20060705214502.GA27597@elte.hu>
	<20060705145826.fc549c7f.rdunlap@xenotime.net>
	<20060705220009.GB32040@elte.hu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 00:00:09 +0200 Ingo Molnar wrote:

> 
> * Randy.Dunlap <rdunlap@xenotime.net> wrote:
> 
> > > well, the allnoconfig thing is artificial (and the uninteresting) for a 
> > > number of reasons:
> > 
> > hm, I'd have to say that allyesconfig is also artificial and the 
> > savings numbers are somewhat uninteresting in that case too.
> 
> well the 'allyesconfig' isnt the true allyesconfig but one with most 
> debugging options disabled. It is quite close to a typical distro config 
> - hence very much relevant. (I wanted to use something that is easy to 
> reproduce.) Believe me, for large configs the savings are real.

I would expect distros to use something close to all*mod*config
(with some debug options disabled).

---
~Randy
