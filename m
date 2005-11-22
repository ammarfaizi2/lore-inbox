Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVKVAPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVKVAPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVKVAPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:15:50 -0500
Received: from quechua.inka.de ([193.197.184.2]:18411 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S964788AbVKVAPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:15:49 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <200511211252.04217.rob@landley.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EeLp5-0002fZ-00@calista.inka.de>
Date: Tue, 22 Nov 2005 01:15:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200511211252.04217.rob@landley.net> you wrote:
> I believe that on 64 bit platforms, Linux has a 64 bit clean VFS.  Python says 
> 2**64 is 18446744073709551616, and that's roughly:
> 18,446,744,073,709,551,616 bytes
> 18,446,744,073,709 megs
> 18,446,744,073 gigs
> 18,446,744 terabytes
> 18,446 ...  what are those, petabytes?
> 18 Really big lumps of data we won't be using for a while yet.

The prolem is not about file size. It is about for example unique inode
numbers. If you have a file system which spans multiple volumnes and maybe
nodes, you need more unqiue methods of addressing the files and blocks.

Gruss
Bernd
