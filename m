Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbTDOVlv (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264114AbTDOVlv 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:41:51 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8871 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264112AbTDOVlt 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 17:41:49 -0400
Date: Tue, 15 Apr 2003 14:51:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Robert Love <rml@tech9.net>
Cc: patmans@us.ibm.com, gert.vervoort@hccnet.nl, tconnors@astro.swin.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
Message-Id: <20030415145155.49df44c7.rddunlap@osdl.org>
In-Reply-To: <1050442676.3664.162.camel@localhost>
References: <3E982AAC.3060606@hccnet.nl>
	<1050172083.2291.459.camel@localhost>
	<3E993C54.40805@hccnet.nl>
	<1050255133.733.6.camel@localhost>
	<3E99A1E4.30904@hccnet.nl>
	<20030415120000.A30422@beaverton.ibm.com>
	<1050442676.3664.162.camel@localhost>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Apr 2003 17:37:56 -0400 Robert Love <rml@tech9.net> wrote:

| On Tue, 2003-04-15 at 15:00, Patrick Mansfield wrote:
| 
| > We never hold the host_lock while calling the detect function (unlike the
| > io_request_lock, see the bizzare 2.4 code), so acquiring it inside
| > ppa_detect is very wrong. I don't know why your scsi scan did not hang.
| 
| I do not have this device so I cannot test it, but your logic seems
| correct.
| 
| This is a much nicer fix for the preempt-related issues than others
| proposed, too.
| 
| Anyone out there who _can_ mount the device?  Can you test this?  It
| ought to be merged if it works.  We need to get device drivers in 2.5 up
| to par..

I have such a device at home.  I can try to test it (if the device
still works).  What needs to be tested?

or maybe I can loan it to patmans for 1 day...

--
~Randy
