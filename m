Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030600AbVLWQjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030600AbVLWQjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 11:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030634AbVLWQjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 11:39:23 -0500
Received: from news.cistron.nl ([62.216.30.38]:7651 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1030601AbVLWQjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 11:39:23 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: scsi errors with dpt-i2o driver
Date: Fri, 23 Dec 2005 16:39:22 +0000 (UTC)
Organization: Cistron
Message-ID: <doh97q$6pl$1@news.cistron.nl>
References: <20051222144348.85266.qmail@web34104.mail.mud.yahoo.com> <1135263384.2940.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1135355962 6965 194.109.0.112 (23 Dec 2005 16:39:22 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1135263384.2940.40.camel@laptopd505.fenrus.org>,
Arjan van de Ven  <arjan@infradead.org> wrote:
>
>> Are there any suggestions about how to diagnose further?  What about
>trying the native i2o driver?
>
>that one is highly preferred anyway nowadays...

Well in 64-bit mode it's still very very unstable at least with
the Adaptec dpt 2005/2010/2015 series adapters. Also it doesn't
support 32-bit legacy ioctls and the raidtools package doesn't
compile correctly on 64-bits (it compiles but doesn't work).

The 64-bit version of dpt_i2o that you can get from Adaptec on
request (unfortunately the 64 bit patches aren't in mainline (yet?))
works fine and is rock-stable.

Mike.
-- 
Freedom is no longer a problem.

