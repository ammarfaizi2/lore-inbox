Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTIRR4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 13:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbTIRR4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 13:56:10 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:64010 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262001AbTIRR4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 13:56:08 -0400
Date: Thu, 18 Sep 2003 19:54:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Make modules_install doesn't create /lib/modules/$version
Message-ID: <20030918175428.GA1095@mars.ravnborg.org>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <200309180321.40307.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309180321.40307.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 03:21:40AM -0400, Rob Landley wrote:
> I've installed -test3, -test4, and now -test5, and each time make 
> modules_install died with the following error:
> 
> Kernel: arch/i386/boot/bzImage is ready
> sh arch/i386/boot/install.sh 2.6.0-test5 arch/i386/boot/bzImage System.map ""
> /lib/modules/2.6.0-test5 is not a directory.
> mkinitrd failed
> make[1]: *** [install] Error 1
> make: *** [install] Error 2
> 
> I had to create the directory in question by hand, and then run it again, at 
> which point it worked.

I usually do:
make install
make modules_install

The first step creates the directory for me. (RH 8.0).

	Sam
