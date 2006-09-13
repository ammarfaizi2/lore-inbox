Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWIMAhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWIMAhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWIMAhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:37:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46726 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751307AbWIMAhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:37:14 -0400
Date: Tue, 12 Sep 2006 17:36:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, linux-audit@redhat.com
Subject: Re: [git pull] audit updates and fixes
In-Reply-To: <20060912071429.GB29920@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0609121735540.4388@g5.osdl.org>
References: <E1GMpjB-0002Ek-NP@ZenIV.linux.org.uk> <20060911180346.c4bfd211.akpm@osdl.org>
 <20060912071429.GB29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Sep 2006, Al Viro wrote:
> 
> [ObGit: git-diff after git-mv + modify a couple of lines generates
> deletion+new file instead of rename.  Weird...]

No it doesn't.

Are you sure you used the "-M" flag to ask for renames?

The other alternative is that the file was so small that the change is 
considered significant, and it becomes a rewrite.

		Linus
