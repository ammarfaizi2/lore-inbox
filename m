Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVE0QLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVE0QLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 12:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVE0QLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 12:11:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:50834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262486AbVE0QLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 12:11:05 -0400
Date: Fri, 27 May 2005 09:13:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jaroslav Kysela <perex@suse.cz>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: ALSA official git repository
In-Reply-To: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 May 2005, Jaroslav Kysela wrote:
> 
> 	I created new git tree for the ALSA project at:
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

Your scripts(?) to generate these things are a bit strange, since they
leave an extra empty line in the commit message, which confuses at least
gitweb (ie just look at

   http://www.kernel.org/git/?p=linux/kernel/git/perex/alsa.git;a=summary

and note how the summary thing looks empty).

Now, arguably gitweb should ignore whitespace at the beginning, but 
equally arguably your commits shouldn't have them either...

		Linus

