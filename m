Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWDJSYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWDJSYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWDJSYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:24:45 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:60682 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932065AbWDJSYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:24:45 -0400
Date: Mon, 10 Apr 2006 20:24:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Adrian Bunk <bunk@stusta.de>, Aubrey <aubreylee@gmail.com>,
       Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: The assemble file under the driver folder can not be recognized when the driver is built as module
Message-ID: <20060410182421.GA22440@mars.ravnborg.org>
References: <6d6a94c50604100316j43bcc32p6fa781c0ce47182d@mail.gmail.com> <20060410112817.GE12896@harddisk-recovery.com> <6d6a94c50604100627q297b7335yb58288356aaa8edd@mail.gmail.com> <20060410174252.GD2408@stusta.de> <Pine.LNX.4.61.0604101402400.26129@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604101402400.26129@chaos.analogic.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 02:04:59PM -0400, linux-os (Dick Johnson) wrote:
 
> Can't he just put his own private compile definition in his
> own Makefile?
> 
> %.o:	%.S
>  	as -o $@ $<

That would never generate a module anyway. And kbuild support building
.o from .S with all the kbuild argument chechking etc.
Doing it so would be wrong.

	Sam
