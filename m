Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbTHSUBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTHSUAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:00:55 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:964 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261458AbTHSUAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:00:16 -0400
Date: Tue, 19 Aug 2003 15:57:56 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Dave Olien <dmo@osdl.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move DAC960 GAM IOCTLs into a new device
In-Reply-To: <20030819181801.GA11704@osdl.org>
Message-ID: <Pine.GSO.4.33.0308191542450.7750-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, Dave Olien wrote:
>...  It introduces a new "miscellaneous" device
>named /dev/dac960_gam.  It uses minor device number 252 of the miscellaneous
>character devices.

And what happens when there are more than one DAC in the system?  Why not
put it where the rest of the DAC devices are? (/dev/rd/gam/c0 or something)

--Ricky



