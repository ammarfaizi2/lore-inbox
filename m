Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWFSHAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWFSHAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 03:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWFSHAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 03:00:37 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:11449 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751224AbWFSHAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 03:00:36 -0400
Message-ID: <44964AC5.8020808@aitel.hist.no>
Date: Mon, 19 Jun 2006 08:57:09 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17: networking bug??
References: <448EC6F3.3060002@rtr.ca>
In-Reply-To: <448EC6F3.3060002@rtr.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Not bloody likely, I suppose.
>
> But with 2.6.17-rc6, I am unable to talk to the webserver at 
> www.everymac.com
> and with 2.6.16.18 (configured identically), this works just fine.
>
> This is with a very simple text access: {"telnet www.everymac.com 80", 
> "GET /", "", ""}
>
> Does that site work for anyone else here running 2.6.17-rc6 ??
2.6.17-rc5-mm2:

GET /                   does nothing.
GET index.html  brings me an error message from the server.

So communication seems to work?

Helge Hafting
