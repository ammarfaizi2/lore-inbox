Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269750AbTGVHFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 03:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269919AbTGVHFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 03:05:22 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:2065 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S269750AbTGVHFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 03:05:19 -0400
Date: Tue, 22 Jul 2003 09:19:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Samuel Flory <sflory@rackable.com>
Cc: Charles Lepple <clepple@ghz.cc>, michaelm <admin@www0.org>,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: Make menuconfig broken
Message-ID: <20030722071957.GA1470@mars.ravnborg.org>
Mail-Followup-To: Samuel Flory <sflory@rackable.com>,
	Charles Lepple <clepple@ghz.cc>, michaelm <admin@www0.org>,
	linux-kernel@vger.kernel.org, zippel@linux-m68k.org
References: <20030721163517.GA597@www0.org> <32425.216.12.38.216.1058806931.squirrel@www.ghz.cc> <3F1C8739.2030707@rackable.com> <3F1C888B.8040500@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1C888B.8040500@rackable.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 05:42:51PM -0700, Samuel Flory wrote:
> 
>  There is no option for CONFIG_VT, and CONFIG_VT_CONSOLE under 
> character devices in "make menuconfig.
> 
>  This works:
> rm .config
> make mrproper
> cp arch/i386/defconfig .config
> make menuconfig

The preferred way to achieve the default configuration is to use:
make defconfig

See also "make help" for a list of more options.

	Sam
