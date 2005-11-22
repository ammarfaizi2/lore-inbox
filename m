Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVKVHPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVKVHPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 02:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVKVHPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 02:15:25 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:30685
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932180AbVKVHPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 02:15:24 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Bernd Eckenfels <ecki@lina.inka.de>
Subject: Re: what is our answer to ZFS?
Date: Tue, 22 Nov 2005 01:15:17 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <E1EeLp5-0002fZ-00@calista.inka.de>
In-Reply-To: <E1EeLp5-0002fZ-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511220115.17450.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 18:15, Bernd Eckenfels wrote:
> In article <200511211252.04217.rob@landley.net> you wrote:
> > I believe that on 64 bit platforms, Linux has a 64 bit clean VFS.  Python
> > says 2**64 is 18446744073709551616, and that's roughly:
> > 18,446,744,073,709,551,616 bytes
> > 18,446,744,073,709 megs
> > 18,446,744,073 gigs
> > 18,446,744 terabytes
> > 18,446 ...  what are those, petabytes?
> > 18 Really big lumps of data we won't be using for a while yet.
>
> The prolem is not about file size. It is about for example unique inode
> numbers. If you have a file system which spans multiple volumnes and maybe
> nodes, you need more unqiue methods of addressing the files and blocks.

18 quintillion inodes are enough to give every ipv4 address on the internet 4 
billion unique inodes.  I take it this is not enough space for Sun to work 
out a reasonable allocation strategy in?

Rob


