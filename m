Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132821AbRDYNav>; Wed, 25 Apr 2001 09:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135199AbRDYNam>; Wed, 25 Apr 2001 09:30:42 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:39947
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S132821AbRDYNa3>; Wed, 25 Apr 2001 09:30:29 -0400
Date: Wed, 25 Apr 2001 09:29:53 -0400
From: Chris Mason <mason@suse.com>
To: Pavel Machek <pavel@suse.cz>, viro@math.psu.edu,
        kernel list <linux-kernel@vger.kernel.org>
cc: torvalds@transmeta.com
Subject: Re: [patch] linux likes to kill bad inodes
Message-ID: <302200000.988205393@tiny>
In-Reply-To: <20010422141042.A1354@bug.ucw.cz>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, April 22, 2001 02:10:42 PM +0200 Pavel Machek <pavel@suse.cz>
wrote:

> Hi!
> 
> I had a temporary disk failure (played with acpi too much). What
> happened was that disk was not able to do anything for five minutes
> or so. When disk recovered, linux happily overwrote all inodes it
> could not read while disk was down with zeros -> massive disk
> corruption.
> 
> Solution is not to write bad inodes back to disk.
> 

Wouldn't we rather make it so bad inodes don't get marked dirty at all?

-chris

