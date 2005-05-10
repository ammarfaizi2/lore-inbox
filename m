Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVEJNiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVEJNiD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 09:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVEJNiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 09:38:02 -0400
Received: from marasystems.com ([83.241.133.2]:6078 "EHLO
	filer.marasystems.com") by vger.kernel.org with ESMTP
	id S261645AbVEJNh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 09:37:57 -0400
Date: Tue, 10 May 2005 15:37:33 +0200 (CEST)
From: Henrik Nordstrom <uml@hno.marasystems.com>
To: Andrew Morton <akpm@osdl.org>
cc: blaisorblade@yahoo.it, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/6] uml: remove elf.h [ compile-fix,
 for 2.6.12 ]
In-Reply-To: <20050509183401.28082cbc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505101525360.16461@filer.marasystems.com>
References: <20050509224509.0C105416E4@zion> <20050509183401.28082cbc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, Andrew Morton wrote:

>> diff -L include/asm-um/elf.h -puN include/asm-um/elf.h~uml-remove-elf-h /dev/null
>
> hmm, that's exciting.  How to tell diff and patch to remove a zero-length
> file?

This has to be instructed by the patch.. If the new file is an empty file 
with timestamp of 1 Jan 1970 then it is supposed to be deleted.

The /dev/null trick only works well for adding files, not removing them.

Regards
Henrik
