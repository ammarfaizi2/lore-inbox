Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTJ0SSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTJ0SSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:18:47 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:54208 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263475AbTJ0SSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:18:45 -0500
Message-ID: <3F9D62DD.9020503@pacbell.net>
Date: Mon, 27 Oct 2003 10:24:29 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: ian.soboroff@nist.gov
CC: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: APM suspend still broken in -test9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Those are the same symptoms I saw in test7, fixed by:

   http://marc.theaimsgroup.com/?l=linux-kernel&m=106606272103414&w=2

Patrick, were you going to submit your patch to resolve this?
I'm thinking this kind of problem would meet Linus's test10
integration criteria.

(That's not an APM problem, it's a generic PM problem that'd
show up with swsusp too.  And likely even some ACPI systems.)

- Dave


