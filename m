Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264961AbSKERJc>; Tue, 5 Nov 2002 12:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264952AbSKERH5>; Tue, 5 Nov 2002 12:07:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:15538 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264951AbSKERHb>;
	Tue, 5 Nov 2002 12:07:31 -0500
Date: Tue, 5 Nov 2002 17:13:03 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105171303.GA20881@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC7FB11.10209@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 12:08:33PM -0500, Jeff Garzik wrote:

 > >Can it really be that one cannot edit a config file and run make
 > >oldconfig anymore? I'm used to editing an entry in .config and running
 > >oldconfig to fix things up, now it just reenables the option. That's
 > >clearly a major regression.
 > > 
 > It works fine for me :)
 > I don't think I could survive without the tried and true "vi .config ; 
 > make oldconfig" kernel configurator :)

Here it seems to work fine if I delete a line completely, but
if I change
CONFIG_FOO=y
to
#CONFIG_FOO=y

it regenerates .config without the #
This used to work fine. I guess the new parser
is a little more strict..


		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
