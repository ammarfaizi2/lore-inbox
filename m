Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263255AbTHVQVJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTHVQVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:21:09 -0400
Received: from gateway.i-a-i.com ([63.122.105.2]:57098 "EHLO i-a-i.com")
	by vger.kernel.org with ESMTP id S263255AbTHVQVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:21:06 -0400
Subject: Re: Reinjecting IP Packets
From: Patrick Sodre Carlos <klist@i-a-i.com>
To: Ben Greear <greearb@candelatech.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3F464177.1020709@candelatech.com>
References: <1061563295.824.4.camel@iai68>
	 <3F464177.1020709@candelatech.com>
Content-Type: text/plain
Organization: Intelligent Automation Inc.
Message-Id: <1061569442.2060.2.camel@iai68>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Aug 2003 12:24:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   My mistake... I forgot to mention that the packet will be coming from
user-space.

Patrick

On Fri, 2003-08-22 at 12:14, Ben Greear wrote:
> Patrick Sodre Carlos wrote:
> > Hi Guys,
> >    I'm trying to figure out what is the best way to reinject IP packets
> > into the stack. Does anyone have good/right/left ideas on this?
> 
> Maybe netif_rx() in net/core/dev.c ?
> 
> Ben
> 
> 
