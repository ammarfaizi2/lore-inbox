Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSGQLnL>; Wed, 17 Jul 2002 07:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318241AbSGQLnK>; Wed, 17 Jul 2002 07:43:10 -0400
Received: from dsl-213-023-052-194.arcor-ip.net ([213.23.52.194]:12997 "EHLO
	duron.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S315946AbSGQLnK>; Wed, 17 Jul 2002 07:43:10 -0400
Date: Wed, 17 Jul 2002 13:46:05 +0200
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac7
Message-ID: <20020717114605.GA12575@duron.intern.kubla.de>
References: <200207171056.g6HAuXR24678@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207171056.g6HAuXR24678@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 06:56:33AM -0400, Alan Cox wrote:
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> Linux 2.4.19rc1-ac7

Seems to have some problems:

[...]
make[1]: Entering directory `/usr/src/linux'
scripts/split-include include/linux/autoconf.h include/config
/usr/bin/make -r -f tmp_include_depends all
make[2]: Entering directory `/usr/src/linux'
make[2]: *** No rule to make target
`/usr/src/linux/fs/inflate_fs/infblock.h', needed by
`/usr/src/linux/fs/inflate_fs/infcodes.h'.  Stop.
make[2]: Leaving directory `/usr/src/linux'
make[1]: *** [tmp_include_depends] Error 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Error 2

Dominik
-- 
UFO is a SIG at the University of Mainz. Meetings are every odd monday of
the month in the workstation laboratory (Zentrum fuer Datenverarbeitung).
We are a Unix derivate independent group.  Every flavor of Unix is welcome.
