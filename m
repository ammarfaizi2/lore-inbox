Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVBIAV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVBIAV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 19:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVBIAV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 19:21:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51342 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261712AbVBIAV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 19:21:56 -0500
Date: Wed, 9 Feb 2005 00:21:55 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Vineet Joglekar <vintya@excite.com>
Cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
Subject: Re: Problem in accessing executable files
Message-ID: <20050209002155.GY8859@parcelfarce.linux.theplanet.co.uk>
References: <20050209001427.61C438AF24@xprdmailfe2.nwk.excite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209001427.61C438AF24@xprdmailfe2.nwk.excite.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 07:14:27PM -0500, Vineet Joglekar wrote:
> 
> Hi all,
> 
> 
> 
> 1 more interesting observation regarding my executable file problem.
> 
> 
> 
> If I copy an executable say "prac" from ext2 fs to my encrypted fs as prac1, prac1 doesnt run on the encrypted fs. but, if I make another copy, from prac1 to normal ext2 fs, as prac2, then the prac2 executes properly on normal file system. that means my encryption, decryption functions are getting executed properly while using that executable as normal file to read and write, but something else is happening when I try to execute it. I am failing to understand what am I missing.

1) 6 or 7 newlines
2) mmap()
