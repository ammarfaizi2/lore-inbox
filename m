Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbTATSo1>; Mon, 20 Jan 2003 13:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbTATSo1>; Mon, 20 Jan 2003 13:44:27 -0500
Received: from mail.webmaster.com ([216.152.64.131]:17398 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S266520AbTATSo0> convert rfc822-to-8bit; Mon, 20 Jan 2003 13:44:26 -0500
From: David Schwartz <davids@webmaster.com>
To: <tytso@mit.edu>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Mon, 20 Jan 2003 10:53:25 -0800
In-Reply-To: <20030120155523.GB3513@think.thunk.org>
Subject: Re: Is the BitKeeper network protocol documented?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030120185326.AAA14936@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>You need to distinguish between how information is stored, and the
>information itself.  If I store the master repository for an Open
>Source project on an NTFS filesystem, does that make the NTFS
>filesystem part of the preferred form?  Of course not!  You might
>have
>to use the NTFS filesystem to get at the sources, but that doesn't
>make it part of the preferred form.

>                        - Ted

	I think you're deliberately glossing over a critical distinction. 
Taking source code out of an NTFS filesystem and packing it up in a 
tarball doesn't obfuscate the source and in no way affects your 
ability to make changes to the source. Taking source code out of a 
version control system obfuscates the rationale for changes and makes 
it more difficult to modify the source.

	I would argue that if the development of a project is based around a 
version control system, checking the source out of that version 
control system is equivalent to stripping the comments out of it.

	The GPL makes it quite clear that the source code is not "whatever 
you can compile to get the executable", but it is the source code in 
its preferred form for modifications. The loss of metainformation 
helpful to modifying the source, such as check-in comments, is 
different from the loss of irrelevant metainformation such as inode 
numbers.

	DS


