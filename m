Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263649AbTCXJMC>; Mon, 24 Mar 2003 04:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263801AbTCXJMC>; Mon, 24 Mar 2003 04:12:02 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:56324 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S263649AbTCXJMC>;
	Mon, 24 Mar 2003 04:12:02 -0500
Date: Mon, 24 Mar 2003 10:23:07 +0100
From: Martin Mares <mj@ucw.cz>
To: shesha bhushan <bhushan_vadulas@hotmail.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: GETHOSTBYNAME()
Message-ID: <20030324092307.GA658@ucw.cz>
References: <F88IYUmwO9suAkWORuX000101d2@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F88IYUmwO9suAkWORuX000101d2@hotmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  data = gethostbyname("158.168.1.1");

If you use gethostbyname only on numerical addresses, then it's fine to
replace it by htonl(0x98a80101) etc.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A Bash poem: time for echo in canyon; do echo $echo $echo; done
