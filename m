Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTI2XIr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 19:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTI2XIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 19:08:47 -0400
Received: from hell.org.pl ([212.244.218.42]:24076 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263078AbTI2XIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 19:08:45 -0400
Date: Tue, 30 Sep 2003 01:15:08 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PM][INPUT] keyboard dead after resuming from S3
Message-ID: <20030929231508.GA5963@hell.org.pl>
References: <20030929211344.GC12894@hell.org.pl> <20030929212925.GA19916@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20030929212925.GA19916@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Vojtech Pavlik:
> > with this by reloading atkbd.ko. However, for newer ones (2.6.0-test5-mm4,
> > specifically), I can't do that, as the following appears:
> > 
> > atkbd: Unknown symbol dump_i8042_history
> > 
> > A similar warning is issued at depmod stage.
> You probably have the atkbd module from a different kernel version.
> Rebuild your atkbd module.

Definitely not, and I've just done a make mrproper to ensure that. Will try
with a different version, though.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
