Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSGVGV4>; Mon, 22 Jul 2002 02:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSGVGVz>; Mon, 22 Jul 2002 02:21:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22284 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316465AbSGVGVy>;
	Mon, 22 Jul 2002 02:21:54 -0400
Message-ID: <3D3BA71B.9E6DF92E@zip.com.au>
Date: Sun, 21 Jul 2002 23:32:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ville Herva <vherva@niksula.hut.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 buffer layer error at page-writeback.c:420
References: <20020721120837.GJ1548@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> 
> I just booted 2.5.26 to textmode, logged in as root and left it there. After
> a while I got this.

urgh.  OK, thanks.  It's that dang ramdisk driver again.
I'll take a look.

> After that, floppy access etc fails.

That would probably be unrelated - the message is just a
warning/debug thing.

-
