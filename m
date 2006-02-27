Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWB0XeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWB0XeD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWB0XeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:34:03 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:42893 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751784AbWB0XeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:34:02 -0500
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
From: Nicholas Miell <nmiell@comcast.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Benjamin LaHaise <bcrl@kvack.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, perex@suse.cz, Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20060227210427.GU27946@ftp.linux.org.uk>
References: <20060227190150.GA9121@kroah.com>
	 <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de>
	 <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org>
	 <20060227210427.GU27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 15:33:57 -0800
Message-Id: <1141083237.3000.5.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 21:04 +0000, Al Viro wrote:
> On Mon, Feb 27, 2006 at 12:20:49PM -0800, Linus Torvalds wrote:
> > They seem to be just excuses for bad habits. And the notion of a "private" 
> > interface is insane anyway, since it doesn't matter - the only thing that 
> > matters is whether it breaks existing binaries or not, and being "private" 
> > in no way makes any difference to that. If you need to compile or link 
> > against a new library, it's broken - whether it was "private" or not makes 
> > no difference.
> 
> gregkh is being polite - s/private/but-we-are-special/ and it will make
> more sense...


I agree with the criticism of the private interfaces, but unstable makes
sense in the new kernel development model world -- "testing" is "we're
pretty sure that this is done but it might not be and we might change it
in the future, so pay attention" while "unstable" is more of a "we think
the design is neat, but somebody is bound to find some way we've screwed
it up and it'll probably be changed in the future to fix it, so expect
your programs to break".

-- 
Nicholas Miell <nmiell@comcast.net>

