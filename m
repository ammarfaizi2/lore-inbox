Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTEBIuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 04:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTEBIuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 04:50:00 -0400
Received: from quechua.inka.de ([193.197.184.2]:7369 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261970AbTEBIt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 04:49:58 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: sendfile
In-Reply-To: <Pine.LNX.4.40L0.0305020124050.1874-100000@ketil.hb.local>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19BWQu-00063L-00@calista.inka.de>
Date: Fri, 02 May 2003 11:02:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.40L0.0305020124050.1874-100000@ketil.hb.local> you wrote:
> I don't think TCP is suitable for streaming multimedia stuff to clients.
> For instance, if a packet does not arrive on the client, it's better to
> handle this in the client and skip a frame or show one of worse quality
> than to have the video stop while waiting for the server to resend.

Yes, this is a problem, but on the other hand, if you want to stream to a
large number of clients, you need to consider deployment and firewalling
issues. 

Nearly all streaming applications out there nowaday offer at least a TCP (or
HTTP) fallback, or use only TCP.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
