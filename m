Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSGVIwZ>; Mon, 22 Jul 2002 04:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSGVIwZ>; Mon, 22 Jul 2002 04:52:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61455 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316592AbSGVIwY>; Mon, 22 Jul 2002 04:52:24 -0400
Date: Mon, 22 Jul 2002 09:55:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Keith Owens <kaos@ocs.com.au>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.25 net/core/Makefile
Message-ID: <20020722095528.A2534@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207221032510.8911-100000@serv> <jek7nof8m8.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <jek7nof8m8.fsf@sykes.suse.de>; from schwab@suse.de on Mon, Jul 22, 2002 at 10:51:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 10:51:43AM +0200, Andreas Schwab wrote:
> They do, see for example load_config_file in scripts/Menuconfig, or around
> line 556 in script/Configure.

What Roman is meaning is something like this:

if [ "$CONFIG_FOO" = "y" ]; then
   choice ...
fi

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

