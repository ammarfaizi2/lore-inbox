Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbULHAZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbULHAZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 19:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbULHAZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 19:25:07 -0500
Received: from thunk.org ([69.25.196.29]:14818 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261958AbULHAZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 19:25:04 -0500
Date: Tue, 7 Dec 2004 15:11:02 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG in fs/ext3/dir.c
Message-ID: <20041207201102.GA5177@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Holger Kiehl <Holger.Kiehl@dwd.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0412070953190.11134@diagnostix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412070953190.11134@diagnostix.dwd.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 09:56:26AM +0000, Holger Kiehl wrote:
> [Sorry if you get this twice. This was send to ext3-users@redhat.com and
>  the authors of ext3, but got no responce.]

I'm on ext3-users, but I didn't get the e-mail.....  so this is the
first time I've seen this.

> When using readdir() on a directory with many files or long file names
> it can happen that it returns the same file name twice. Attached is
> a program that demonstrates this. 

Thanks for the test case, I'm currently looking at the problem....

						- Ted
