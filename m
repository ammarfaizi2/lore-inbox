Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTEWJOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTEWJOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:14:31 -0400
Received: from web11803.mail.yahoo.com ([216.136.172.157]:47653 "HELO
	web11803.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263971AbTEWJO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:14:27 -0400
Message-ID: <20030523092733.58183.qmail@web11803.mail.yahoo.com>
Date: Fri, 23 May 2003 11:27:33 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: 2.5.69 doesn't boot
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> # Character devices
>> #
>> # CONFIG_VT is not set
>> # CONFIG_SERIAL_NONSTANDARD is not set
>
>No VT console is set.

 Did someone noticed that if a user want to test Linux-2.5,
 he downloads for the first time a 2.5 kernel, extract and type
make menuconfig
 and that takes its default (.config) from the only kernel
 available on his (really standard) distribution - a 2.4.* kernel.

 Then, there isn't any CONFIG_VT to choose for (I do not know
 why) - it is completely undefined and not present in the menus.
 If you type "make bzImage; cp bzImage /boot" you get a kernel
 which seems to crash at startup even for the simplest
 configuration you've choosen.

 The obvious solution is to do - when it is the first time you
 configure a 2.5.* kernel, the line:
cp arch/i386/defconfig .config
 but I am not sure this is intuitive enough...

  Etienne.

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
