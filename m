Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbVJEE3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbVJEE3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 00:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbVJEE3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 00:29:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55493 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965069AbVJEE3u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 00:29:50 -0400
Date: Wed, 5 Oct 2005 05:29:45 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc_mkdir() should be used to create procfs directories
Message-ID: <20051005042945.GS7992@ftp.linux.org.uk>
References: <20050928213257.GA7992@ftp.linux.org.uk> <2cd57c900510021844kc24938es8904dfe888f561d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900510021844kc24938es8904dfe888f561d8@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 09:44:07AM +0800, Coywolf Qi Hunt wrote:
> On 9/29/05, Al Viro <viro@ftp.linux.org.uk> wrote:
> >         A bunch of create_proc_dir_entry() calls creating directories
> > had crept in since the last sweep; converted to proc_mkdir().
> 
> I only see create_proc_entry(), no create_proc_dir_entry().

What you see is a typo in patch description ;-)
