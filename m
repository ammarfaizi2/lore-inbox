Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTF2UNv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265070AbTF2ULz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:11:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45464 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264930AbTF2UKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:10:51 -0400
Date: Sun, 29 Jun 2003 21:25:09 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas
Message-ID: <20030629202509.GJ27348@parcelfarce.linux.theplanet.co.uk>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <20030629192847.GB26258@mail.jlokier.co.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk> <200306291545410600.02136814@smtp.comcast.net> <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.55.0306291317300.14949@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0306291317300.14949@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 01:19:24PM -0700, Davide Libenzi wrote:

> > AFAICS, it is _very_ hard to implement.  Even outside of the kernel.
> > If you can get it done - well, that might do a lot for having the
> > idea considered seriously.  "Might" since you need to do it in a way
> > that would survive transplantation into the kernel _and_ would scale
> > better that O((number of filesystem types)^2).
> 
> Maybe defining a "neutral" metadata export/import might help in limiting
> such NFS^2 ...

Go for it - do it in userland, define the mapping between various sorts
of metadata and let's see how well you can make it work.  Have fun.
