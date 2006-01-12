Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161298AbWALV0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161298AbWALV0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161299AbWALV0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:26:08 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:48142 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161298AbWALV0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:26:08 -0500
Date: Thu, 12 Jan 2006 22:25:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Cal Peake <cp@absolutedigital.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] kbuild: drop vmlinux dependency from "make install"
Message-ID: <20060112212532.GA8665@mars.ravnborg.org>
References: <11368427243850@foobar.com> <Pine.LNX.4.61.0601121118550.6734@lancer.cnet.absolutedigital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601121118550.6734@lancer.cnet.absolutedigital.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 11:21:51AM -0500, Cal Peake wrote:
> On Mon, 9 Jan 2006, Sam Ravnborg wrote:
> 
> > This removes the dependency from vmlinux to install, thus avoiding the
> > current situation where "make install" has a nasty tendency to leave
> > root-turds in the working directory.
> 
> Is removing the `kernel_install' target considered a userspace interface 
> breakage? ;) Or am I just gonna have to get used to typing `make install' 
> again?
make install is there to stay. And now where install and kernel_install
do the same thing the latter will disappear.
So yes, soon yo have to type less.

	Sam
