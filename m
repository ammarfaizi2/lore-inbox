Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTH3PHM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 11:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTH3PHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 11:07:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39404 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262037AbTH3PHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 11:07:08 -0400
Date: Sat, 30 Aug 2003 12:02:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: john stultz <johnstul@us.ibm.com>
Cc: olof@austin.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: /proc/ioports overrun patch
Message-ID: <Pine.LNX.4.55L.0308301140060.31588@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If so, I would prefer to have a fix which outputs the full resource
> information. For that we would need seq_file().

> I have a patch that converts /proc/interrupts to use seq_file as well,
> however it would be much cleaner if Randy's backport of the "single"
> interface went in first

>http://www.ussg.iu.edu/hypermail/linux/kernel/0308.3/0296.html

>Are you planning on taking that patch? Or should I just resend my patch
> w/o it?

I applied the seq file single interfaces now.
