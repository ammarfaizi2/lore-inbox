Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSIHTHc>; Sun, 8 Sep 2002 15:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSIHTHb>; Sun, 8 Sep 2002 15:07:31 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:13073 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S313558AbSIHTHa>;
	Sun, 8 Sep 2002 15:07:30 -0400
Date: Sun, 8 Sep 2002 21:23:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: jbradford@dial.pipex.com
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: clean before or after dep?
Message-ID: <20020908212354.A1791@mars.ravnborg.org>
Mail-Followup-To: jbradford@dial.pipex.com,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20020908205011.A1671@mars.ravnborg.org> <200209081854.g88Isuxk003676@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209081854.g88Isuxk003676@darkstar.example.net>; from jbradford@dial.pipex.com on Sun, Sep 08, 2002 at 07:54:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2002 at 07:54:56PM +0100, jbradford@dial.pipex.com wrote:
> > Lets go through the targets in question, and their purpose:
> > mrproper:
> > mrproper removes all files generated during the build process. This
> > includes the final kernel, the current configuration, firmware for
> > drivers, host-progs used during compilation, buildversion, 
> > the include/asm link and a few more files.
> 
> This used to be called distclean, right?
Nope, distclean is still present.
distclean in addition to mrproper removes all editor backup files, patch
leftovers, md5 sum files, and empty files.

So three leves of cleaning.

	Sam

