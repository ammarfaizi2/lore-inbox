Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbTBCVWA>; Mon, 3 Feb 2003 16:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbTBCVWA>; Mon, 3 Feb 2003 16:22:00 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:52498 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264877AbTBCVWA>;
	Mon, 3 Feb 2003 16:22:00 -0500
Date: Mon, 3 Feb 2003 22:31:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Konrad Eisele <eiselekd@web.de>
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
Subject: Re: Customflags for cmd_objcopy
Message-ID: <20030203213108.GB910@mars.ravnborg.org>
Mail-Followup-To: Konrad Eisele <eiselekd@web.de>,
	kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
References: <200302031605.h13G5nO30068@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302031605.h13G5nO30068@mailgate5.cinetic.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 05:05:49PM +0100, Konrad Eisele wrote:
> like with cmd_ld in scripts/Makefile.lib having possibility to add 
> customflags with cmk_objcopy would be nice. When building a ROMKernel
> I'd like to use:
> OBJCOPYFLAGS_rompiggydata := --remove-section=.text
> OBJCOPYFLAGS_$(MODEL)piggytext := --only-section=.text

Looks good to me.

	Sam
