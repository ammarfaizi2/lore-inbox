Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTILOHy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 10:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbTILOHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 10:07:54 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:26007 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261707AbTILOHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 10:07:53 -0400
Message-ID: <3F61D322.7020507@nortelnetworks.com>
Date: Fri, 12 Sep 2003 10:07:30 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Rahul Karnik <rahul@genebrew.com>, rusty@linux.co.intel.com,
       riel@conectiva.com.br, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Enabling other oom schemes
References: <200309120219.h8C2JANc004514@penguin.co.intel.com> <3F614912.3090801@genebrew.com> <3F614C1F.6010802@nortelnetworks.com> <20030912111808.GA13973@hh.idb.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> On Fri, Sep 12, 2003 at 12:31:27AM -0400, Chris Friesen wrote:

> Note that this "memory" is RAM+swap.  So you can avoid allocation
> failure by giving your strict overcommit box much more swap space.

This works great for the desktop, doesn't work so well when you don't 
have any swap--as is the case for most embedded apps that would like 
stricter overcommit.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

