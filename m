Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTILT4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTILT4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:56:48 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:3857 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261280AbTILT4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:56:47 -0400
Date: Fri, 12 Sep 2003 21:56:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: sanjay kumar <isanjaykumar@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: building kelnel 2.6
Message-ID: <20030912195645.GA3812@mars.ravnborg.org>
Mail-Followup-To: sanjay kumar <isanjaykumar@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20030912194348.76701.qmail@web20712.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912194348.76701.qmail@web20712.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 12:43:48PM -0700, sanjay kumar wrote:
> hi,
>   i am not able to build modules in linux-2.6.0-test5.
> there is not any error, but it is not building all the
> 
> modules. only
> /lib/modules/2.6.0-testacpismp/kernel/drivers/net/dummy.ko
> is generated after doing make modules_install.

If you use 'make defconfig' to establish your configuration, then
this is the only module that will be build.
Use 'make menuconfig' to check was it being selected as module '<M>',
and what is selected as built-in <*>.

	Sam
