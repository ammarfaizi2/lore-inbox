Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTI3Ejd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 00:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTI3Ejd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 00:39:33 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:59075 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263106AbTI3Ejc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 00:39:32 -0400
Date: Tue, 30 Sep 2003 06:39:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PM][INPUT] keyboard dead after resuming from S3
Message-ID: <20030930043925.GA20603@ucw.cz>
References: <20030929211344.GC12894@hell.org.pl> <20030929212925.GA19916@ucw.cz> <20030929231508.GA5963@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929231508.GA5963@hell.org.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 01:15:08AM +0200, Karol Kozimor wrote:

> Thus wrote Vojtech Pavlik:
> > > with this by reloading atkbd.ko. However, for newer ones (2.6.0-test5-mm4,
> > > specifically), I can't do that, as the following appears:
> > > 
> > > atkbd: Unknown symbol dump_i8042_history
> > > 
> > > A similar warning is issued at depmod stage.
> > You probably have the atkbd module from a different kernel version.
> > Rebuild your atkbd module.
> 
> Definitely not, and I've just done a make mrproper to ensure that. Will try
> with a different version, though.
> Best regards,

Ok, then it's some patch that's in -mm4 and isn't in -test6 and -bk* trees.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
