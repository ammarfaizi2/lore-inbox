Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263068AbREaL0x>; Thu, 31 May 2001 07:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263070AbREaL0d>; Thu, 31 May 2001 07:26:33 -0400
Received: from kashiwa8-77.ppp-1.dion.ne.jp ([210.157.148.77]:45072 "EHLO
	ask.ne.jp") by vger.kernel.org with ESMTP id <S263068AbREaL0c>;
	Thu, 31 May 2001 07:26:32 -0400
Date: Thu, 31 May 2001 20:28:20 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Bjorn Wesen <bjorn.wesen@axis.com>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Only 5 undocumented configuration symbols left
Message-Id: <20010531202820.0ac5bf9d.bruce@ask.ne.jp>
In-Reply-To: <Pine.LNX.4.21.0105311213261.28884-100000@godzilla.axis.se>
In-Reply-To: <20010530190744.A2027@thyrsus.com>
	<Pine.LNX.4.21.0105311213261.28884-100000@godzilla.axis.se>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since I don't actually know what you're talking about, I'll just make picky
little comments about the grammar, etc. ;)

On Thu, 31 May 2001 12:14:06 +0200 (CEST)
Bjorn Wesen <bjorn.wesen@axis.com> wrote:

> +Etrax100 I2C configuration
> +CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C
> +  Select whether to use the special I2C mode in the PB I/O register or
> +  not. This option needs to be selected in order to use some drivers that
> +  accesses the I2C I/O pins directly instead of going through the I2C
     ^^^^^^^^
     access

> +  driver, like the DS1302 realtime-clock driver. If you are uncertain, 
> +  choose yes here.
     ^^^^^^^^^^^^^^^
This is usually "say Y here." Minor, I know, but it'd be nice to get the
nomenclature standardized.

(Actually, "...to be selected in order to use some drivers, such as the DS1302
realtime clock driver, that access the I2C I/O pins directly instead of going
through the I2C driver." might scan better.)


Bruce


