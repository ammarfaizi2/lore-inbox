Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTFXQyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTFXQyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:54:31 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:40721 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262390AbTFXQy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:54:27 -0400
Date: Tue, 24 Jun 2003 19:08:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: jds <jds@soltis.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems when compile kernel 2.5.73-mm1
Message-ID: <20030624170833.GA8469@mars.ravnborg.org>
Mail-Followup-To: jds <jds@soltis.cc>, linux-kernel@vger.kernel.org
References: <20030624151611.M70129@soltis.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624151611.M70129@soltis.cc>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 09:18:46AM -0600, jds wrote:
> Hi Andrew:
> 
>    I have problems whe try the compile kernel. the messages is:
> 
> [root@toshiba linux-2.5]# make bzImage
>                  from init/main.c:26:
> include/linux/mm.h: In function `lowmem_page_address':
> include/linux/mm.h:344: `__PAGE_OFFSET' undeclared (first use in this function)
> [root@toshiba linux-2.5]#
> 
> Helpme please 
Reported already.
make menuconfig
save
make
Did the trick last time. I dunno why.

	Sam
