Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbUJaVJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbUJaVJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUJaVIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:08:06 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10469 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261485AbUJaVGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:06:51 -0500
Date: Sun, 31 Oct 2004 22:06:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
In-Reply-To: <20041031201500.GA4498@thunk.org>
Message-ID: <Pine.LNX.4.53.0410312205370.11558@yvahk01.tjqt.qr>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
 <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
 <1099170891.1424.1.camel@krustophenia.net> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
 <20041030222720.GA22753@hockin.org> <4184193A.3060406@pobox.com>
 <20041031201500.GA4498@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>.... if you don't mind bloating your application:
>
>% ls -l /usr/lib/libxml2.a
>4224 -rw-r--r--  1 root root 4312536 Oct 19 21:55 /usr/lib/libxml2.a

Whoa. Bet its creator compiled with -g -O2 rather than -g0 -O2. ANd with
-static instead of with <dynamic>. Yay look at this:

22:06 io:~ # l /usr/lib/libxml2.so -L
#SUSE# -rwxr-xr-x  1 root root 1145089 Apr  6  2004 /usr/lib/libxml2.so

4x smaller!



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
