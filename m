Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266420AbUAVTwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266422AbUAVTwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:52:51 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:41220 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S266420AbUAVTws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:52:48 -0500
To: ncunningham@users.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Shutdown IDE before powering off.
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <1074800199.12771.110.camel@laptop-linux> (Nigel Cunningham's
 message of "Fri, 23 Jan 2004 08:36:40 +1300")
References: <1074735774.31963.82.camel@laptop-linux>
	<20040121234956.557d8a40.akpm@osdl.org>
	<200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk>
	<m3y8rzlrj5.fsf@lugabout.jhcloos.org>
	<1074800199.12771.110.camel@laptop-linux>
Date: Thu, 22 Jan 2004 14:52:33 -0500
Message-ID: <m3r7xrlq0u.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Nigel" == Nigel Cunningham <ncunningham@users.sourceforge.net> writes:

Nigel> Actually, we wouldn't want to call sync
Nigel> anyway for reasons I won't go into here

Sorry for the confusion; I didn't mean call sync so much as flush
synchronously (ie wait for the drive to ack) thrice before the reboot.

-JimC

