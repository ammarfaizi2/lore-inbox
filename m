Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267373AbSLLBZi>; Wed, 11 Dec 2002 20:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbSLLBZi>; Wed, 11 Dec 2002 20:25:38 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:63366 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267373AbSLLBZi>; Wed, 11 Dec 2002 20:25:38 -0500
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: hidden interface (ARP) 2.4.20
In-Reply-To: <Pine.LNX.3.96.1021211110329.18520C-100000@gatekeeper.tmr.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.14-20020917 ("Chop Suey!") (UNIX) (Linux/2.4.18-xfs (i686))
Message-Id: <E18MIE3-0001GW-00@calista.inka.de>
Date: Thu, 12 Dec 2002 02:33:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.96.1021211110329.18520C-100000@gatekeeper.tmr.com> you wrote:
> Don't. You are right about this one, a client originated connection will
> have an ARP entry and route back by the original route.

Most likely it will not have an ARP entry, since there is only the ARP entry
for the router. Not-directly connected hosts are not listed in the
neighbours cache, but yes, you will have an routing cache entry (netstat
-C).


Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
