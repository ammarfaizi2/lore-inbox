Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbTF2VBD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 17:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbTF2U6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:58:06 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:41093 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262872AbTF2U5e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:57:34 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 29 Jun 2003 14:10:22 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: rmoser <mlmoser@comcast.net>
cc: Hugo Mills <hugo-lkml@carfax.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas
In-Reply-To: <200306291700340120.0257F7AF@smtp.comcast.net>
Message-ID: <Pine.LNX.4.55.0306291409360.14949@bigblue.dev.mcafeelabs.com>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
 <200306291545410600.02136814@smtp.comcast.net>
 <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
 <200306291629450990.023BC35E@smtp.comcast.net> <20030629205003.GA4298@carfax.org.uk>
 <200306291700340120.0257F7AF@smtp.comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jun 2003, rmoser wrote:

> >> I've beaten the O((FS_COUNT)^2) already.  And by the way, it's
> >> O((FS_COUNT)*(FS_COUNT - 1_).  There's exactly O(2*FS_COUNT)
> >> and o(2*FS_COUNT) sets of code needed total to be able to convert
> >> between any two filesystems.
> >
> >   There's no such thing as O(x*(x-1)). This is precisely O(x^2).
> >Similarly, O(2*x) is precisely the same as O(x). If you're going to
> >try to use mathematics to demonstrate your point, please at least make
> >sure that you're using it _right_.
> >
>
> Big O notation is inappropriate here because it measures time complexity;
> however, I was following Viro's lead.  We're using it to measure code
> complexity, sorry.

In which math book O() is a time thingy ?


- Davide

