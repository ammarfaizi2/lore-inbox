Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310532AbSCGUwc>; Thu, 7 Mar 2002 15:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310536AbSCGUwa>; Thu, 7 Mar 2002 15:52:30 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:39179 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S310532AbSCGUvY>;
	Thu, 7 Mar 2002 15:51:24 -0500
Date: Thu, 7 Mar 2002 20:51:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: wolvie_cobain <wolvie@punkass.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile time problem
Message-ID: <20020307195157.GB331@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.2002221227050.1724-100000@redtalon.wolves.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.2002221227050.1724-100000@redtalon.wolves.com.br>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> i get this on the make bzImage

gcc bug. Add volatile's to all local variables in blk_ioctl, and it
will compile.
								Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
