Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbTISInY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 04:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbTISInY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 04:43:24 -0400
Received: from gw-nl3.philips.com ([212.153.190.5]:6374 "EHLO
	gw-nl3.philips.com") by vger.kernel.org with ESMTP id S261439AbTISInW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 04:43:22 -0400
Message-ID: <3F6AC11D.40103@basmevissen.nl>
Date: Fri, 19 Sep 2003 10:41:01 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rob@landley.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Make modules_install doesn't create /lib/modules/$version
References: <200309180321.40307.rob@landley.net>
In-Reply-To: <200309180321.40307.rob@landley.net>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

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
> 
> Am I the only person this is happening for?  (Bog standard Red Hat 9 system 
> otherwise.  With Rusty's modutils...)
> 

I didn't see that here with Red Hat 9 system and 2.6.0-test3.

Maybe you can greb the used scripts to see which one does make (or test 
the existence of) the directory.

I now use the modutils package from rawhide. It also handles the 
creation of the new /etc/modprobe.conf file.

Bas.



