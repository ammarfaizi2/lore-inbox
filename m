Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTL3So4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 13:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTL3So4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 13:44:56 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:59844 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263806AbTL3Soz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 13:44:55 -0500
Subject: Re: The survival of ide-scsi in 2.6.x
From: James Bottomley <James.Bottomley@steeleye.com>
To: Willem Riede <wrlk@riede.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Dec 2003 12:44:49 -0600
Message-Id: <1072809890.2839.24.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    If people will have me, I am prepared to take on that responsibility.
    I am just concerned that I may not have enough of a variety of devices
    to be able to thoroughly test it (unless the DI-30 is the only one :-)).
    What do people see as the requirements to be able to maintain ide-scsi?
    
Well...there's currently not a long line of people wanting to do this,
so feel free to send in patches (at least cc'd to linux-scsi so I can
pick them up easily), and we'll see how it goes.

In the long term, I think libata will end up assuming much of the role
that ide-scsi does now, but since it doesn't interface to a lot of
existing motherboard chipsets, we're going to need ide-scsi around for a
while at least.

James




