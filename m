Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWJXJDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWJXJDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 05:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWJXJDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 05:03:40 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:14015 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1030242AbWJXJDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 05:03:38 -0400
Date: Tue, 24 Oct 2006 05:03:19 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Martin Waitz <tali@admingilde.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01 of 23] VFS: change struct file to use struct path
Message-ID: <20061024090319.GA18110@filer.fsl.cs.sunysb.edu>
References: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu> <b212ecc85fa3ad0382f6.1161411446@thor.fsl.cs.sunysb.edu> <20061021002200.4731cdeb.akpm@osdl.org> <20061021072807.GF30620@filer.fsl.cs.sunysb.edu> <20061023114736.GA15167@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023114736.GA15167@admingilde.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 01:47:36PM +0200, Martin Waitz wrote:
> hoi :)
> 
> On Sat, Oct 21, 2006 at 03:28:07AM -0400, Josef Sipek wrote:
> > > why?
> > 
> > It's little cleaner than having two pointers. In general, there is a number
> > of users of dentry-vfsmount pairs in the kernel, and struct path nicely
> > wraps it.
> 
> Sure, but you can split the patch up:
> 
> First, change struct file and introduce the #defines so that everything
> still works as before.

That's what 01 does (along with fs/*.[ch] changes).

Josef "Jeff" Sipek.

-- 
Mankind invented the atomic bomb, but no mouse would ever construct a
mousetrap.
		- Albert Einstein
