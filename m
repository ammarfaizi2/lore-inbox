Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTF0Kws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 06:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTF0Kws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 06:52:48 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55364 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264158AbTF0Kws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 06:52:48 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200306271107.h5RB72x32196@devserv.devel.redhat.com>
Subject: Re: O_DIRECT
To: sct@redhat.com (Stephen C. Tweedie)
Date: Fri, 27 Jun 2003 07:07:02 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), sct@redhat.com (Stephen Tweedie),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <1056710121.2418.19.camel@sisko.scot.redhat.com> from "Stephen C. Tweedie" at Meh 27, 2003 11:35:21 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ouch ouch ouch, there's nasty merge conflict between the O_DIRECT patch
> and an existing 64-bit rlimit chunk in -ac3.  You really, really want
> the change below. :-)  Marcelo's tree appears OK, and this is a common
> code path for all filesystems in -ac, so it matches the failure patterns
> that far.

Ouch indeed - ok thats good, that means its not the O_DIRECT stuff. Thanks
for figuring it out
