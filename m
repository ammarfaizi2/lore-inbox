Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUBJApY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUBJApV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:45:21 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:35031 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265590AbUBJAn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 19:43:56 -0500
Message-ID: <40282A37.4090502@comcast.net>
Date: Mon, 09 Feb 2004 18:47:51 -0600
From: Karl Tatgenhorst <ketatgenhorst@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
References: <c07c67$vrs$1@terminus.zytor.com>
In-Reply-To: <c07c67$vrs$1@terminus.zytor.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

>Hi all,
>
>Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?  I'm
>thinking of restructuring the pty system slightly to make it more
>dynamic and to make use of the new larger dev_t, and I'd like to get
>rid of the BSD ptys as part of the same patch.
>
>	-hpa
>  
>
Hi,

      Thanks for asking. I had a critical application that depended on 
them until last week and am now happy to say that even they have moved 
on (I protested the small number of available ptys and explained the 
direction that Unix is going with Unix98 style ptys. Now I depend on 
those. I would be very interested in seeing what you do with your pty 
restructuring as I have a large amount of serial devices.

Karl Tatgenhorst

