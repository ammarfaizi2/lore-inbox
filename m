Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUDSRBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUDSRBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:01:23 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:65034 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261500AbUDSRBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:01:18 -0400
Date: Mon, 19 Apr 2004 19:01:33 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Fabian Fenaut <fabian.fenaut@free.fr>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Sensors (W83627HF) in Tyan S2882
Message-Id: <20040419190133.351d1401.khali@linux-fr.org>
In-Reply-To: <200404191600.i3JG0ElX089970@zone3.gcu-squad.org>
References: <1082387882.4083edaa52780@imp.gcu.info>
	<200404191600.i3JG0ElX089970@zone3.gcu-squad.org>
Reply-To: sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Nice catching. However the fix is not correct. "W83627HF" is the
> > correct name and "W83682HF" is the typo.
> 
> You sure ? Looks like W83627HF is handled by the 2nd one, no ?

Sure. Both drivers handle it. The w83267hf driver is prefered if the
chip is found on the ISA bus, however the w83781d is the only one that
can handle the chip if it's on the I2C bus.

For a list of supported chips for each driver, you can take a look at
the comments in the headers of the source files.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
