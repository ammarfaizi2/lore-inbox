Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTESSVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTESSVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:21:34 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:24335 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261624AbTESSVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:21:32 -0400
Date: Mon, 19 May 2003 18:34:24 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: David Ford <david+cert@blue-labs.org>
Cc: arjanv@redhat.com, Christoph Hellwig <hch@infradead.org>,
       Martin Schlemmer <azarah@gentoo.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030519183424.E7061@devserv.devel.redhat.com>
References: <1053289316.10127.41.camel@nosferatu.lan> <20030518204956.GB8978@holomorphy.com> <1053292339.10127.45.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519124539.B8868@infradead.org> <3EC91B6D.9070308@blue-labs.org> <1053367592.1424.8.camel@laptop.fenrus.com> <3EC9212C.4070303@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EC9212C.4070303@blue-labs.org>; from david+cert@blue-labs.org on Mon, May 19, 2003 at 02:23:40PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, May 19, 2003 at 02:23:40PM -0400, David Ford wrote:
> I didn't miss the point.  

The rest of your mail suggests otherwise

> I don't use RH, and I'm not in a mood to switch to RH just because
> RH has an LK headers maintainer.

It;s not about using RH. At all. You obviously didn't read
my mail. First you say "nobody is doing the work" to which I respond
"I am, and you even don't have to use RH to benifit from it". 

> The question is how to make these headers.  Who decides what should and 
> shouldn't be available to userland?

For the header set I maintain, I did. Based on the criterium "does
this describe a kernel<->userland ABI".

> AFAIK, you don't have a package that contains all the -current- headers 
> for all the current versions of all these various projects applied to 
> the kernel headers and then sanitized.

You really don't get it. 
If a userspace app needs something REALLY special from headers, it
should bloody well come with that header. 

>  I want to use my hardware that 
> is supported by version X of the package's software but the headers only 
> have version M supported.  Wireless extensions for example.

Ok to take your example: the wireless extension using apps
should include THEIR header for the extensions THEIR released userland
is for, unless they want to use the sanitized headers (which should have
latest). The kernel<->userspace ABI is stable, and compatible between
kernel versions. 


> The question is how to make these headers.  Nobody wants to say how and 
> when someone needs an answer, even a distro maintainer, the answer is a 
> flippant "don't use kernel headers / use your vendor".  I haven't seen 
> otherwise

I tried several times to tell you, you just don't want to hear the answer
it seems.
