Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbUAGGEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 01:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266140AbUAGGEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 01:04:05 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:23300 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264899AbUAGGED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 01:04:03 -0500
Date: Wed, 7 Jan 2004 07:16:28 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel buildsystem broken on RO medium
Message-ID: <20040107061628.GA2165@mars.ravnborg.org>
Mail-Followup-To: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
	linux-kernel@vger.kernel.org
References: <200401070041.41598.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401070041.41598.arekm@pld-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 12:41:41AM +0100, Arkadiusz Miskiewicz wrote:
> How to build external kernel modules using kernel buildsystem from RO medium?
> 
> 
> make[1]: Entering directory `/home/users/misiek/rpm/BUILD/drbd-0.6.10/drbd'
> 
>     Calling toplevel makefile of kernel source tree, which I believe is in
>     KDIR=/lib/modules/2.6.1/build
>     NOTE: please ignore warnings regarding overriding of SUBDIRS
> 
> /usr/bin/make -C /lib/modules/2.6.1/build 
> SUBDIRS=/home/users/misiek/rpm/BUILD/drbd-0.6.10/drbd  modules

Use the O= option to specify a separate output directory,
where you have RW permissions.

	Sam
