Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285267AbRLFWlD>; Thu, 6 Dec 2001 17:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285265AbRLFWku>; Thu, 6 Dec 2001 17:40:50 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64268
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S285255AbRLFWje>; Thu, 6 Dec 2001 17:39:34 -0500
Date: Thu, 6 Dec 2001 14:35:29 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Paul Bristow <paul@paulbristow.net>
cc: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x 2.5.x wishlist
In-Reply-To: <3C0FE745.7090903@paulbristow.net>
Message-ID: <Pine.LNX.4.10.10112061433100.15265-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Paul Bristow wrote:

> joeja@mindspring.com wrote:
> 
> > I tried the patch on your site against 2.4.14, it helped, system still hung... 
> 
> 
> Damn.  Lost interrupt is outside my code.  This lives in the ide driver 
> proper and is probably relative toi the via82cxxx specific controller 
> code that is deep voodoo from Andre.  I guess Andre/Jens have not found 
> all the *funnies* in the buggy chipset.

Paul I have to finish a packet_taskfile_ioctl for seeing if we have to
correct data-transport rules in place.  For the longest time it has been a
pig in a poke.  The ATAPI diagnostics toolkit will be significantly
tougher but still doable.

Regards,

Andre Hedrick
Linux ATA Development

