Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbTL2TXo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTL2TXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:23:44 -0500
Received: from 12-229-138-12.client.attbi.com ([12.229.138.12]:42880 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S264480AbTL2TXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:23:43 -0500
Message-ID: <3FF07F3E.2090405@comcast.net>
Date: Mon, 29 Dec 2003 11:23:42 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <3FEF89D5.4090103@comcast.net> <3FEF8BB1.6090704@wmich.edu> <3FEFA36A.5050307@comcast.net> <3FEFDE4A.1030208@wmich.edu> <3FF0580C.5070604@comcast.net> <3FF06A26.8060609@wmich.edu>
In-Reply-To: <3FF06A26.8060609@wmich.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> check out test11-mm1's cdrom.c.  I think it'll make things clear.  I
> just replaced the cdrom.c and ide-cd.h and ide-cd.c files in 2.6.0-mm1
> with 2.6.0-test11-mm1's and things are working perfect.
> 
> 
> 

Ed,

I can confirm that 2.6.0-mm2 fixes the tray lock issue. On my setup, the drive's
capabilities are reported correctly as well. Haven't done serious testing yet,
but I could at least blank a cd-rw :) yay!

-Walt




