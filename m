Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289826AbSAKBpK>; Thu, 10 Jan 2002 20:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289825AbSAKBo6>; Thu, 10 Jan 2002 20:44:58 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:58342 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S289822AbSAKBoq>; Thu, 10 Jan 2002 20:44:46 -0500
Date: Thu, 10 Jan 2002 20:48:01 -0500
To: bunk@fs.tum.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18pre3
Message-ID: <20020110204801.A7049@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> something changed between pre2 and pre3 that broke the booting of
> non-modular kernels. After LILO's "Loading Linux" message nothing else
> happens. When I enable CONFIG_MODULES my kernel boots.

Maybe lilo didn't execute properly.

/usr/src/linux$ egrep 'CONFIG_MOD|=m' .config
# CONFIG_MODULES is not set

/usr/src/linux$ uname -a
Linux mountain 2.4.18-pre3 #1 Thu Jan 10 20:13:52 EST 2002 i586 unknown

-- 
Randy Hron

