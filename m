Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTHVQOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbTHVQOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:14:53 -0400
Received: from evrtwa1-ar2-4-33-045-084.evrtwa1.dsl-verizon.net ([4.33.45.84]:54218
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S263412AbTHVQOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:14:51 -0400
Message-ID: <3F464177.1020709@candelatech.com>
Date: Fri, 22 Aug 2003 09:14:47 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Sodre Carlos <klist@i-a-i.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Reinjecting IP Packets
References: <1061563295.824.4.camel@iai68>
In-Reply-To: <1061563295.824.4.camel@iai68>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Sodre Carlos wrote:
> Hi Guys,
>    I'm trying to figure out what is the best way to reinject IP packets
> into the stack. Does anyone have good/right/left ideas on this?

Maybe netif_rx() in net/core/dev.c ?

Ben



-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


