Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVDTEjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVDTEjk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 00:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVDTEjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 00:39:40 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:31683 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261393AbVDTEjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 00:39:22 -0400
Date: Wed, 20 Apr 2005 06:39:16 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Phil Lougher <phil.lougher@gmail.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
Message-ID: <20050420043915.GA21753@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr> <20050323174925.GA3272@zero> <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be> <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com> <d1v67l$4dv$1@terminus.zytor.com> <3e74c9409b6e383b7b398fe919418d54@mac.com> <cce9e37e0503251948527d322b@mail.gmail.com> <4244DC6A.3020304@zytor.com> <4244C57A.6040609@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4244C57A.6040609@lougher.demon.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 March 2005 02:14:18 +0000, Phillip Lougher wrote:
> 
> Fixing it in Squashfs implies Squashfs is broken.  It isn't.  If it has 
> to be "fixed" in the kenel, fix it in the VFS, it is after all the VFS 
> which makes '.' and '..' handling redundant in the filesystem.

There are some islands on this planet where behaviour of virtually all
the population wrt. driving on the proper side of the road is broken.
Those people are silly, sure.

Still, does that make you drive on the proper side while everyone else
tries to evade your car with furious maneuvers?

So, what do we learn from these silly islands?  "Wrong" and "Right"
are relative, sometimes is makes much more sense to say "oh well, let
them have their way".


Anyway, I took a look at squashfs and will send you patches shortly.
Hope you don't mind.

Jörn

-- 
Anything that can go wrong, will.
-- Finagle's Law
