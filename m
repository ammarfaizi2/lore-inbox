Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbUCOW0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUCOWWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:22:46 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:11275 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262835AbUCOWWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:22:24 -0500
Date: Mon, 15 Mar 2004 23:04:53 +0100
From: Willy Tarreau <willy@w.ods.org>
To: herbert@13thfloor.at, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04
Message-ID: <20040315220453.GA19556@alpha.home.local>
References: <20040315035350.GA30948@MAIL.13thfloor.at> <20040315045952.GD14537@alpha.home.local> <20040315053654.GA31818@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315053654.GA31818@MAIL.13thfloor.at>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Mon, Mar 15, 2004 at 06:36:55AM +0100, Herbert Poetzl wrote:
> > # mount /dev/hdaXX /mnt/disk
> > # mount -r --bind /mnt/disk /mnt/ro
> > # touch /mnt/ro/foo
> > Read-only file-system (that's what was expected)
> > # umount /mnt/ro
> > (I don't remember if the problem already arises here)
> > # umount /mnt/disk
> > device is busy
> 
> this has been fixed in 0.04 for 2.4.25, if you need
> the fix to include for 0.03 (for whatever reason)
> here is the relevant hunk ..

I can confirm that it now works perfectly, as expected.

Thank you very much,
Willy

