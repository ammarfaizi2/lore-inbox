Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTJARtY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 13:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTJARtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 13:49:24 -0400
Received: from codepoet.org ([166.70.99.138]:48303 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S262074AbTJARtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 13:49:19 -0400
Date: Wed, 1 Oct 2003 11:49:06 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Paul Rolland <rol@as2917.net>
Cc: "'Jens Axboe'" <axboe@suse.de>, "'David S. Miller'" <davem@redhat.com>,
       "'Andreas Steinmetz'" <ast@domdv.de>, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20031001174906.GA12587@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Paul Rolland <rol@as2917.net>, 'Jens Axboe' <axboe@suse.de>,
	"'David S. Miller'" <davem@redhat.com>,
	'Andreas Steinmetz' <ast@domdv.de>, schilling@fokus.fraunhofer.de,
	linux-kernel@vger.kernel.org
References: <20030930190908.GC5407@codepoet.org> <022901c387f8$d35c3320$4300a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022901c387f8$d35c3320$4300a8c0@witbe>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 01, 2003 at 10:48:45AM +0200, Paul Rolland wrote:
> Hello,
> 
> > A classic recent example is iproute, which uses kernel headers
> > all over the place.  It compiled with earlier 2.4.x kernels, but
> > it no longer compiles 2.4.22.  I've not bothered to try and fix
> > it, but if it included its own set of sanitized kernel headers,
> > it would not have had a problem.
> 
> And if some IOCTLs were changed in between, in the kernel and
> kernel headers ? 
> You end up with an application that you can compile, but doesn't
> behave as expected ? What a progress :-(

People who change ioctl numbers needs their kneecaps broken.
Regardless, I didn't say I liked the current situation.  I
just said that is the current officially sanctioned method
of dealing with it,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
