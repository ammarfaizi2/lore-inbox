Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277471AbRJOL43>; Mon, 15 Oct 2001 07:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277437AbRJOL4T>; Mon, 15 Oct 2001 07:56:19 -0400
Received: from cogito.cam.org ([198.168.100.2]:54283 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S277434AbRJOL4D>;
	Mon, 15 Oct 2001 07:56:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: Chris Mason <mason@suse.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: mount hanging 2.4.12
Date: Mon, 15 Oct 2001 07:50:35 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110141231570.6026-100000@weyl.math.psu.edu> <2314290000.1003133922@tiny>
In-Reply-To: <2314290000.1003133922@tiny>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011015115036.1997EC9C4@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 15, 2001 04:18 am, Chris Mason wrote:
> [ bad lvm<->reiserfs locking patch causes hangs ]
>
> Ok, here's an updated patch, one liner fix from the original.

An important line though.  It now works.

mount /fuji
umount /fuji
change media 
mount /fuji (which gets an I/0 error reading the boot sector) 
mount /fuji

This is using usb-storage and sddr-09 support.

Thanks Everyone
Ed Tomlinson
