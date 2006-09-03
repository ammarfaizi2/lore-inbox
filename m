Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWIDMdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWIDMdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWIDMdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:33:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44039 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964856AbWIDMds
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:33:48 -0400
Date: Sun, 3 Sep 2006 11:05:08 +0000
From: Pavel Machek <pavel@suse.cz>
To: Josef Sipek <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification Filesystem
Message-ID: <20060903110507.GD4884@ucw.cz>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - Modifying a Unionfs branch directly, while the union is mounted, is
>   currently unsupported.  Any such change may cause Unionfs to oops and it
>   can even result in data loss!

I'm not sure if that is acceptable. Even root user should be unable to
oops the kernel using 'normal' actions.
						Pavel
-- 
Thanks for all the (sleeping) penguins.

-- 
VGER BF report: H 5.1371e-14
