Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbTDSOcR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 10:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTDSOcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 10:32:17 -0400
Received: from quechua.inka.de ([193.197.184.2]:49574 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263393AbTDSOcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 10:32:16 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kstrdup
In-Reply-To: <1050755240.3277.3.camel@dhcp22.swansea.linux.org.uk>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.18-xfs (i686))
Message-Id: <E196tZc-00016X-00@calista.inka.de>
Date: Sat, 19 Apr 2003 16:44:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1050755240.3277.3.camel@dhcp22.swansea.linux.org.uk> you wrote:
> You are arguing over a 1 instruction, probably sub 1 clock scheduling
> matter on a call which is not used on any fast or common path. If you
> shaved 1 clock off the timer handling instead you'd make a lot more
> difference..

i think he is arguing about the performance of strcpy vs. memcpy.

Is the 1 instruction longer including the inlined code for those two?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
