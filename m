Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbULEBO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbULEBO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 20:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbULEBO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 20:14:57 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:18842
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261220AbULEBO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 20:14:56 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] relinquish_fs() syscall
Date: Sat, 4 Dec 2004 19:14:03 -0500
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041129114331.GA33900@gaz.sfgoth.com> <20041130141204.GE63669@gaz.sfgoth.com> <1101822206.25617.28.camel@localhost.localdomain>
In-Reply-To: <1101822206.25617.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412041914.03214.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 November 2004 08:43 am, Alan Cox wrote:

> You would probably want a "private" AF_UNIX namespace too. The fact its
> a single namespace for "anonymous" AF_UNIX and the \0 trick is used is
> really legacy unix compatibility. Having multiple such namespaces is
> certainly
> doable. It's the same problem as the shared memory, semaphore and
> message
> queue objects have because they fall out of the filesystem namespace.
> Posix
> has fixed these but very few apps use the new forms.

Looking back at the patched together set of man pages, old printouts, stale 
books, tricks picked up from other people's code, and occasional groveling 
through the kernel and library sources I've used over the years to figure out 
how to program Linux:

Is there a book out there that actually says how we're SUPPOSED to be doing 
all this stuff?  Which APIs are actually recommended for use under 2.6 and 
later?  (Does O'reilley publish an up to date version of the POSIX API, with 
examples?)

Rob
