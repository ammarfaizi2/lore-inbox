Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271193AbTGWSDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271194AbTGWSDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:03:23 -0400
Received: from smtp.terra.es ([213.4.129.129]:35701 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id S271193AbTGWSDU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:03:20 -0400
Date: Wed, 23 Jul 2003 20:17:37 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: hch@infradead.org, tcfelker@mtco.com, linux-kernel@vger.kernel.org
Subject: Re: root= needs hex in 2.6.0-test1-mm2
Message-Id: <20030723201737.27c8fce9.diegocg@teleline.es>
In-Reply-To: <1058972911.718.1.camel@teapot.felipe-alfaro.com>
References: <200307230156.40762.tcfelker@mtco.com>
	<20030723144351.A3367@infradead.org>
	<1058972911.718.1.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El 23 Jul 2003 17:08:31 +0200 Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> escribió:

> I didn't compile devfs in... However, root=/dev/xxx caused a panic
> during bootup. So, I guess those panics aren't related exclusively to
> devfs.

I can confirm this. It happens without devfsd.
The hex trick worked ;)
