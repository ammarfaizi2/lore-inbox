Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270345AbTGWPdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 11:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTGWPdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 11:33:38 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:7133
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S270345AbTGWPdg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 11:33:36 -0400
Message-ID: <31544.216.12.38.216.1058975315.squirrel@www.ghz.cc>
In-Reply-To: <20030723170657.2ba9e7db.florian.huber@mnet-online.de>
References: <200307230156.40762.tcfelker@mtco.com><1058962821.574.0.camel@teapot.felipe-alfaro.com>
    <20030723170657.2ba9e7db.florian.huber@mnet-online.de>
Date: Wed, 23 Jul 2003 11:48:35 -0400 (EDT)
Subject: Re: root= needs hex in 2.6.0-test1-mm2
From: "Charles Lepple" <clepple@ghz.cc>
To: "Florian Huber" <florian.huber@mnet-online.de>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Florian Huber said:
> On 23 Jul 2003 14:20:21 +0200
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
>> I would say it's a bug :-)
>
> "It's not a bug, it's an undocumented feature" ;)
>
> On the one hand it sounds reasonable tom me that I cannot use the
> device "path", because devfs sets it, but why has it changed? It
> seemed to work well with older kernel versions. And what do the hex
> numbers stand for?

First two are the device major, second two are the minor.

$ ls -l /dev/hdb1
brw-rw----    1 root     disk       3,  65 Jan 30 05:24 /dev/hdb1

  -> root=0341

-- 
Charles Lepple <ghz.cc!clepple>
http://www.ghz.cc/charles/
