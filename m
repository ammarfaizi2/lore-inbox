Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbRFNIux>; Thu, 14 Jun 2001 04:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbRFNIun>; Thu, 14 Jun 2001 04:50:43 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:18706 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261758AbRFNIug>; Thu, 14 Jun 2001 04:50:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "SATHISH.J" <sathish.j@tatainfotech.com>, linux-kernel@vger.kernel.org
Subject: Re: Reg-directory size
Date: Thu, 14 Jun 2001 10:53:19 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10106141300430.21100-100000@blrmail>
In-Reply-To: <Pine.LNX.4.10.10106141300430.21100-100000@blrmail>
MIME-Version: 1.0
Message-Id: <01061410531904.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 June 2001 09:52, SATHISH.J wrote:
> Hi,
> When we create lot of files and directories under a directory the size of
> the directory changes after aparticular limit. I could find that if the
> size of directory is 4096 it can create 341 files(size of qstr structure
> for each file is 12 bytes,so 4096/12=341.xx) before it changes to 8192.
> Please tell me where in the code does this directory size changes. Is it
> in VFS level or in  the file system level? Please tell me this which would
> be of great use to me.

Filesystem.  Look in fs/ext2/dir.c and namei.c for typical examples.

--
Daniel
