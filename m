Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUCAIZL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUCAIZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:25:11 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:38304 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S262272AbUCAIZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:25:08 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Known problems with megaraid under 2.4.25 highmem?
Date: Mon, 1 Mar 2004 09:27:49 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, Atul Mukker <atulm@lsil.com>
References: <200402271107.42050.tvrtko@croadria.com> <Pine.LNX.4.58L.0402271548290.18958@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402271548290.18958@logos.cnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200403010927.50003.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 February 2004 19:52, Marcelo Tosatti wrote:

> Not known to me...
>
> Can you get any traces from the lockup? NMI watchdog or sysrq+p and +t?

Unfortunately no, it is a production system now to which I don't have physical 
access.

> Did any previous 2.4.x work reliably?

It is a new system, which came with preinstalled RH7.2 and kernel 2.4.23 which 
has highmem support and is stable. I immediately installed 2.4.25 also w/ 
highmem & highmem i/o. After I got one I/O lockup under light load, I 
immediately recompiled wo/ highmem support. After that no problems 
whatsoever.
 
