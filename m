Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbTEVQG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTEVQG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:06:58 -0400
Received: from mail.ccur.com ([208.248.32.212]:46610 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S262031AbTEVQG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:06:57 -0400
Date: Thu, 22 May 2003 12:19:39 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Phil Edwards <phil@jaj.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 SMP, a PDC20269, and a huge Maxtor disk.  Am I doomed?
Message-ID: <20030522161939.GA23140@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20030522134847.GA20179@disaster.jaj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030522134847.GA20179@disaster.jaj.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 09:48:47AM -0400, Phil Edwards wrote:
> In the aftermath of a horrible crash (one minute all was well, the next
> minute all the active ext3 filesystems behaved like they'd been run through a
> cheese grater), I've installed a 200GB Maxtor drive, and a Promise Ultra133
> TX2 card to let me actually use all of it.
> 
> The mobo BIOS doesn't speak 48-bit LBA, so it sees a 137 GB drive.  That's
> fine, I'm guessing, since (I'm told) Linux doesn't get its information
> from the BIOS.


I believe LBA48 was introduced in 2.4.21-pre.  Try 2.4.21-rc2 and see what
happens.

Joe
