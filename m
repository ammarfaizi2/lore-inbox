Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTEHMAX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbTEHMAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:00:23 -0400
Received: from muriel.parsec.at ([80.120.166.1]:24329 "EHLO muriel.parsec.at")
	by vger.kernel.org with ESMTP id S261588AbTEHMAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:00:22 -0400
Date: Thu, 8 May 2003 14:12:17 +0200 (CEST)
From: Andreas Gruenbacher <ag@bestbits.at>
X-X-Sender: <ag@muriel.parsec.at>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       lsm <linux-security-module@wirex.com>,
       lkml <linux-kernel@vger.kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
       <acl-devel@bestbits.at>
Subject: Re: [PATCH] Process Attribute API for Security Modules 2.5.69
In-Reply-To: <1052319765.1044.60.camel@moss-huskers.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.33.0305081405220.14380-100000@muriel.parsec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Process Attribute API, Ext2 xattr handler, and Ext3 xattr handler look
clean, so I have no objections, either. It remains to be seen how useful
this API will be.

It will be necessary to document which security attributes are defined,
and which are their valid values. These things will eventually have to be
incorporated into e2fsck, so that after a file system check it is
guaranteed that the file system is in a consistent state.


Cheers,
Andreas.

------------------------------------------------------------------------
 Andreas Gruenbacher, a.gruenbacher@computer.org
 Contact information: http://www.bestbits.at/~ag/

