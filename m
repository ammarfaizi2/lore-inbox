Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbUCMBz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 20:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbUCMBz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 20:55:29 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:29891 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262978AbUCMBz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 20:55:26 -0500
Date: Fri, 12 Mar 2004 20:55:22 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Urban Widmark <urban@teststation.com>
Cc: Adam Sampson <azz@us-lot.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smbfs Oops with Linux 2.6.3
In-Reply-To: <Pine.LNX.4.44.0403112355350.8470-100000@cola.local>
Message-ID: <Pine.LNX.4.58.0403111928250.29087@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0403112355350.8470-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Urban Widmark wrote:

> Not quite there yet.
>
> I have added a sleep(10); in send_fs_socket (smbmount) to give me time to
> send other requests to the fs. Here is what I get when I run the mount and
> two 'ls' in parallel:

Thanks for testing it, i'll have another go at it.

> The difference must be that in a the inode data for the root inode is not
> considered current when the second ls runs, but I don't understand why the
> readdir is printed before the getattr.

I don't understand why to expect the getattr before the readdir, perhaps
you can elaborate for me?

Thanks,
	Zwane

