Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWHHIQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWHHIQM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWHHIQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:16:12 -0400
Received: from gw.goop.org ([64.81.55.164]:5805 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932552AbWHHIQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:16:10 -0400
Message-ID: <44D8484E.9050904@goop.org>
Date: Tue, 08 Aug 2006 01:16:14 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev <netdev@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2: bad e1000 device name
References: <44D78A48.7050707@goop.org> <20060808004011.ab3cd65f.akpm@osdl.org>
In-Reply-To: <20060808004011.ab3cd65f.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> e1000 seems OK here.  Don't know, sorry.
>   

It's happening to all my ethernet-like devices: the Atheros wireless 
comes up as a mess too.  It's different each time, so it looks like 
random uninitialized crud.

I did a clean rebuild, but it still happens.  I guess I'll have to try 
with some slab debugging and see if its an overrun or something.

    J
