Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTJGXZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 19:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbTJGXZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 19:25:08 -0400
Received: from hell.org.pl ([212.244.218.42]:29200 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262787AbTJGXZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 19:25:05 -0400
Date: Wed, 8 Oct 2003 01:32:46 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PM][INPUT] keyboard dead after resuming from S3
Message-ID: <20031007233246.GA627@hell.org.pl>
References: <20030929211344.GC12894@hell.org.pl> <20030929212925.GA19916@ucw.cz> <20030929231508.GA5963@hell.org.pl> <20030930043925.GA20603@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20030930043925.GA20603@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Vojtech Pavlik:
> > > > A similar warning is issued at depmod stage.
> > > You probably have the atkbd module from a different kernel version.
> > > Rebuild your atkbd module.
> > Definitely not, and I've just done a make mrproper to ensure that. Will try
> > with a different version, though.
> > Best regards,
> Ok, then it's some patch that's in -mm4 and isn't in -test6 and -bk* trees.

Indeed. 2.6.0-test6-vanilla is OK with atkbd.ko and rmmod atkbd; echo 3 >
/proc/acpi/sleep; modprobe atkbd works as expected.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
