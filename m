Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261649AbTCPW7S>; Sun, 16 Mar 2003 17:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262775AbTCPW7S>; Sun, 16 Mar 2003 17:59:18 -0500
Received: from smtp2.EUnet.yu ([194.247.192.51]:58016 "EHLO smtp2.eunet.yu")
	by vger.kernel.org with ESMTP id <S261649AbTCPW7R>;
	Sun, 16 Mar 2003 17:59:17 -0500
From: Toplica Tanaskovic <toptan@EUnet.yu>
To: Sheng Long Gradilla <skamoelf@netscape.net>
Subject: Re: AGP 3.0 for 2.4.21-pre5
Date: Mon, 17 Mar 2003 00:08:41 +0100
User-Agent: KMail/1.5
References: <200303151816.39915.toptan@EUnet.yu> <3E74AC3B.6070404@netscape.net>
In-Reply-To: <3E74AC3B.6070404@netscape.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Message-Id: <200303170008.41525.toptan@EUnet.yu>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by smtp2.eunet.yu id h2GNA9x11012
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana nedelja 16. mart 2003. 17:54 napisali ste:
> I tested it with my NVidia GeForce 4 Ti4200 with AGP8X. No luck for me
> yet. X is still reporting AGP 4X in the log, I get garbage on the screen
> and my PC locks up.
>
> I am not sure if this has something to do with the NVidia driver for X,
> or just a bug in your module/backport.
>
	You have to run make clean first, or faster way go to drivers/char/agp/ and 
delete any .o files, and then do make modules...

	I'll have to figure out way to force compilation of agpgart if only agp 3.0 
menu item was changed.
-- 
Pozdrav,
Tanasković Toplica


