Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315718AbSFOW50>; Sat, 15 Jun 2002 18:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSFOW5Z>; Sat, 15 Jun 2002 18:57:25 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:14341 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S315718AbSFOW5Y>;
	Sat, 15 Jun 2002 18:57:24 -0400
Date: Sun, 16 Jun 2002 01:00:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: John covici <covici@ccs.covici.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.21 make problem
Message-ID: <20020616010006.A19935@mars.ravnborg.org>
In-Reply-To: <15627.30793.979635.330468@ccs.covici.com> <Pine.LNX.4.44.0206151247180.7247-100000@chaos.physics.uiowa.edu> <15627.49665.816993.766199@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2002 at 06:38:57PM -0400, John covici wrote:
> I had the bright idea of taking the clean out of there, so I was left
> with
> make dep bzImage modules_install 2>&1 |tee foo
> 
> but that didn't help -- thought it would.

I have once seen something similar.
Have you tried "make mrproper" to clean up and try again?

	Sam
