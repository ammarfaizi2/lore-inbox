Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWASSbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWASSbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWASSbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:31:10 -0500
Received: from 200-170-96-180.veloxmail.com.br ([200.170.96.180]:16266 "EHLO
	lolita-out.veloxmail.com.br") by vger.kernel.org with ESMTP
	id S1030308AbWASSbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:31:09 -0500
X-Authenticated-User: fredlwm@veloxmail.com.br
X-Authenticated-User: fredlwm@veloxmail.com.br
Date: Thu, 19 Jan 2006 16:31:03 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: create .kernelrelease at *config step
Message-ID: <Pine.LNX.4.64.0601191626140.1300@dyndns.pervalidus.net>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this expected ?

$ cd /usr/local/src/kernel/linux-2.6.16
$ make O=/home/fredlwm/objdir/ oldconfig
...
make -C /usr/local/src/kernel/linux-2.6.16 O=/home/fredlwm/objdir .kernelrelease
Makefile:480: .config: No such file or directory

.config is in /home/fredlwm/objdir

.kernelrelease gets created in 
/usr/local/src/kernel/linux-2.6.16 . I thought nothing would be 
written to the sources directory. What if I were on a read-only 
filesystem ?

I didn't try to build it. Are these harmless ?

-- 
How to contact me - http://www.pervalidus.net/contact.html
