Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265737AbUEZUDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265737AbUEZUDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 16:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUEZUDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 16:03:15 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:30416
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S265737AbUEZUDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 16:03:14 -0400
Date: Wed, 26 May 2004 16:11:27 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040526161127.A30461@animx.eu.org>
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <40B4667B.5040303@nodivisions.com> <40B46A57.4050209@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <40B46A57.4050209@yahoo.com.au>; from Nick Piggin on Wed, May 26, 2004 at 07:58:47PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Come on, that is quite an exaggeration.  It can happen in a span of 
> > minutes -- after rsyncing a dir to a backup dir, for example, which 
> > fills ram rather quickly with cache I'll never use again.  Or after 
> > configuring and compiling a package, which does the same thing.
> > 
> 
> rsync is something known to break the VM's use-once heuristics.
> I'm looking at that.

I have a question about that.  I keep a debian mirror on one of my machines. 
there is over 70000 files.  If I run find on that tree while it's
downloading the file list, it doesn't take as long.  I thought it would be
nice if there was some way I could keep that in memory.  The box has 256mb
ram no swap.  It is configured as diskless.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
