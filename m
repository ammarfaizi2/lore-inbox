Return-Path: <linux-kernel-owner+w=401wt.eu-S1751565AbXAHOrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbXAHOrD (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 09:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbXAHOrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 09:47:03 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:1983 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751565AbXAHOrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 09:47:01 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Dirk <d_i_r_k_@gmx.net>
Subject: Re: Gaming Interface
Date: Mon, 8 Jan 2007 14:47:28 +0000
User-Agent: KMail/1.9.5
Cc: Jay Vaughan <jv@access-music.de>,
       Trent Waddington <trent.waddington@gmail.com>,
       linux-kernel@vger.kernel.org
References: <45A22D69.3010905@gmx.net> <a06230924c1c7d795429a@[192.168.2.101]> <45A24176.9080107@gmx.net>
In-Reply-To: <45A24176.9080107@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701081447.28569.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 January 2007 13:04, Dirk wrote:
> But I don't see top titles ported to SDL/OpenGL.

This is because you're not looking very hard. If you look at Ryan's ports over 
at http://icculus.org/ many of the games (some he's _paid_ to port) use SDL 
statically linked in. There's no legal or technical problem with this.

Really, what you're talking about already exists. If anything, you need to 
convince the SDL guys (not the kernel guys) to make SDL more comprehensive OR 
write your own multimedia library, perhaps based on or backending to SDL.

As noted elsewhere in this thread, most games use 3D hardware exclusively, and 
only really care about the OS for initialising a video mode and playing 
sound.

Most ports probably suffer the worst from the lack of DirectX APIs on Linux, 
something which the WINE project is trying to solve. Using libwine, one will 
eventually be able to write native Linux applications that use the DirectX 
APIs. Porting should then be very much easier.

Of course, vendors using OpenGL gain Macintosh portability amongst other 
things, and most of the really big titles do have OpenGL render modes, which 
are already largely portable.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
