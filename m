Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263438AbSJTSVf>; Sun, 20 Oct 2002 14:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263711AbSJTSVf>; Sun, 20 Oct 2002 14:21:35 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:48910 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263438AbSJTSVe>;
	Sun, 20 Oct 2002 14:21:34 -0400
Date: Sun, 20 Oct 2002 20:27:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44 mrproper removes editor backup files
Message-ID: <20021020202718.B4849@mars.ravnborg.org>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
References: <200210201801.UAA22227@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210201801.UAA22227@harpo.it.uu.se>; from mikpe@csd.uu.se on Sun, Oct 20, 2002 at 08:01:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 08:01:54PM +0200, Mikael Pettersson wrote:
> Contrary to years of history and several explicit comments in
> Makefile that mrproper != distclean, 2.5.44 merged the two
> which causes mrproper to incorrectly remove editor backup files.

Why do you need three levels of cleaning?
In other words what is it that make clean failed to clean in your case.

I know that we always used to say: make mrproper can cure everything.
But make clean starts to get the power of make mrproper.

It makes sense to kill one of them, but make help needs an update though.
You could argue if distclean=mrproper or mrproper=clean.

	Sam
