Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUB0Cco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 21:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbUB0Cco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 21:32:44 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:28629 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261247AbUB0Ccn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 21:32:43 -0500
Date: Thu, 26 Feb 2004 21:32:00 -0500
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] SCSI host num allocation improvement
Message-ID: <20040227023200.GA617@phunnypharm.org>
References: <20040226235412.GA819@phunnypharm.org> <20040226171928.750f5f6f.akpm@osdl.org> <20040226173743.2bf473b4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226173743.2bf473b4.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 05:37:43PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > The lib/idr.c code is a bit clumsy but it does do the job relatively
> > efficiently.
> 
> hmm, not too bad actually.  It compiles, but I didn't test it.

Oh, this isn't any good. It does the same thing as the old way. Steadily
incrementing numbers.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
