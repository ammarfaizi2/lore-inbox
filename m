Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbTF2UjW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTF2Ugx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:36:53 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:32645 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265165AbTF2Udi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:33:38 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 29 Jun 2003 13:46:28 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas
In-Reply-To: <20030629202509.GJ27348@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.55.0306291324590.14949@bigblue.dev.mcafeelabs.com>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
 <200306291545410600.02136814@smtp.comcast.net>
 <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.55.0306291317300.14949@bigblue.dev.mcafeelabs.com>
 <20030629202509.GJ27348@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:

> > Maybe defining a "neutral" metadata export/import might help in limiting
> > such NFS^2 ...
>
> Go for it - do it in userland, define the mapping between various sorts
> of metadata and let's see how well you can make it work.  Have fun.

Al, I don't even think about doing it :) Tar still works for me (and the
neutral format to be compatible with all fs will be nothing more than a
tar can export) and the thing is not even close to be interesting. It was
obvious though that :

# raiser.export | ext2.import && ext2.export | raiser.import

will produce a different raiser metadata.



- Davide

