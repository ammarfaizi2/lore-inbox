Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270797AbTGVL37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 07:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270800AbTGVL37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 07:29:59 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:63435 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP id S270797AbTGVL35
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 07:29:57 -0400
Date: Tue, 22 Jul 2003 04:45:00 -0700
From: Mark McClelland <mark@alpha.dyndns.org>
Subject: Re: APIC support prevents power off
In-reply-to: <200307220835.h6M8Zaqd024427@harpo.it.uu.se>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: rl@hellgate.ch, linux-kernel@vger.kernel.org, mingo@redhat.com
Message-id: <3F1D23BC.6070902@alpha.dyndns.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030707
References: <200307220835.h6M8Zaqd024427@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

> Enabling SMP disables APM's power off code, unless one boots with
> apm=power-off.

apm=smp might also be needed on some machines. My Supermicro P6DGU 
running 2.4.21 only powers off when I boot with both of those 
parameters. apm=power-off alone only worked with 2.4.9 (or maybe older; 
can't remember) kernels.

-- 
Mark McClelland
mark@alpha.dyndns.org

