Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUCCVzI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbUCCVzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:55:08 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:37935 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261171AbUCCVzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:55:04 -0500
Message-ID: <40465460.1050600@myrealbox.com>
Date: Wed, 03 Mar 2004 13:55:44 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040301
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Schlemmer <azarah@gentoo.org>, greg@kroah.com
Subject: udev versus parallel-port Zip drive
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been fiddling with Zip-drive support -- both USB and
parallel-port.

When I compile everything as modules I find that the
parallel-port driver for Zip drives (ppa) does not load
automatically.  To make the parallel Zip drive work I
need to do a 'modprobe ppa' manually, after which everything
works as expected.

I can only imagine the complexity involved in figuring out
what is attached to the parallel port at boot-time -- there
must be thousands of possibilities to sort through.

My question, I suppose, is:  what are the chances that a
parallel-port device can be automatically detected by udev
and the appropriate module loaded?  Is this a pipe-dream?
Or maybe it should already work and I'm just omitting some
important steps?

Any thoughts or suggestions?


