Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTKMBGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 20:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbTKMBGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 20:06:17 -0500
Received: from quechua.inka.de ([193.197.184.2]:3218 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261827AbTKMBGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 20:06:16 -0500
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: So, Poll is not scalable... what to do?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <boufcr$k8l$1@gatekeeper.tmr.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.4.21-xfs (i686))
Message-Id: <E1AK5vv-0006NX-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 13 Nov 2003 02:06:03 +0100
X-Scanner: exiscan *1AK5vv-0006NX-00*srhMtVhWsA2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <boufcr$k8l$1@gatekeeper.tmr.com> you wrote:
> In many cases people just run a thread per socket and use blocking i/o.
> Then the thread either does the work required or make an entry on a
> "work to do" queue.
> 
> You've had other suggestions, this is just for completeness.

This is true for Windows and Java, but how many popular Linux Applications
do it that way? There are much more non-blocking (erlang, boa) or process
based (apache, ...)

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
