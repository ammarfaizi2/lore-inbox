Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbTFRUV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265481AbTFRUV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:21:27 -0400
Received: from pointblue.com.pl ([62.89.73.6]:65042 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S265467AbTFRUTq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:19:46 -0400
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Organization: K4 Labs
To: James Simmons <jsimmons@infradead.org>
Subject: Re: Linux 2.5.71 - random console corruption
Date: Wed, 18 Jun 2003 21:08:00 +0100
User-Agent: KMail/1.5.2
Cc: Gerhard Mack <gmack@innerfire.net>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306182127170.24449-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0306182127170.24449-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306182108.05364@gjs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 18 of June 2003 21:28, James Simmons wrote:

> > Config attached.
>
> You have way to many fbdev drivers turned on. Also the console drivers are
> messed up. Slect one Fbdev driver and framebuffer console or just use
> vgacon.
Shouldn't those drivers detect if they are or not the ones, and if none of 
them is - leave vgacon , if one of them does the job it should set vgacon off 
and use fb ?
What if i will have to decide about configuration for distribution ? where 
everyone nowdays want to boot with logo/fb and so on ?
 
- --
Grzegorz Jaskiewicz
K4 Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+8Malqu082fCQYIgRAjMSAJ4uCzn4EH4pgXstsRSnVBlZiZObggCdEYI8
vCupyDNBt9J9DvSYpE4pxoA=
=vnmZ
-----END PGP SIGNATURE-----

