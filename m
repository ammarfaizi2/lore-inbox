Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270992AbRIJPPU>; Mon, 10 Sep 2001 11:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271213AbRIJPPK>; Mon, 10 Sep 2001 11:15:10 -0400
Received: from mercury.ultramaster.com ([208.222.81.163]:10402 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S270992AbRIJPO5>; Mon, 10 Sep 2001 11:14:57 -0400
Date: Mon, 10 Sep 2001 11:23:36 -0400 (EDT)
From: David Mansfield <david@ultramaster.com>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: kbuild 2.5 question about generated files
Message-ID: <Pine.LNX.4.33.0109101118120.24063-100000@mercury.ultramaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've read the release announcements about the new kbuild and it sounds
like it will be possible to build from kernel sources that reside on a
read-only filesystem?  Is that the case?

In other words, it will be possible to build the kernel in such a way that
NO generated files (including all those generated .h files) get put into
the kernel tree proper?

I'm concerned about the unfixable problems that we had discussed a while
ago about the 'dontdiff' file that someone was maintaining, that listed
some of the generated files (or file patterns) and that in its current
form, such a file CANNOT be made due to name conflics between generated
and non-generated files.

The problem with the 'dontdiff', in case you have forgotten, is that
programs like CVS and diff don't accept path qualifications in the exclude
list, just filename patterns, and there are some conflicts (esp. version.h
IIRC).

David



-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com

