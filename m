Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265395AbRFVMq5>; Fri, 22 Jun 2001 08:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbRFVMqr>; Fri, 22 Jun 2001 08:46:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:22283 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265395AbRFVMqi>; Fri, 22 Jun 2001 08:46:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: hunghochak@netscape.net (Ho Chak Hung), linux-kernel@vger.kernel.org
Subject: Re: Using page cache without a file system
Date: Fri, 22 Jun 2001 14:49:42 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <72AE45C3.2DE2C328.0F76C228@netscape.net>
In-Reply-To: <72AE45C3.2DE2C328.0F76C228@netscape.net>
MIME-Version: 1.0
Message-Id: <01062214494203.00455@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 June 2001 05:33, Ho Chak Hung wrote:
> Is it possible to allocate and add pages to the page cache without a
> underlying file system in Linux 2.4? I know that the host pointer to inode
> structure inside the address_space structure can be NULL, but does this
> mean that we can still make use of page cache operations like readpage or
> writepage if we do not back up the cache with a file system? I am currently
> developing a driver that wants to make use of the page cache, however, I
> want to save myself with the heavy load of kmalloc.
>
> Any hint would be greatly appreciated.

Check out ramfs

--
Daniel
