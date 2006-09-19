Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWISCYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWISCYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 22:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWISCYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 22:24:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751206AbWISCYe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 22:24:34 -0400
Date: Mon, 18 Sep 2006 19:24:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alejandro Riveira =?ISO-8859-1?B?RmVybuFuZGV6?= 
	<ariveira@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "set_rtc_mmss: can't update from m to n" cluttering my logs
Message-Id: <20060918192431.42ec5df5.akpm@osdl.org>
In-Reply-To: <20060918131303.2aed4dc4@localhost.localdomain>
References: <20060918131303.2aed4dc4@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2006 13:13:03 +0200
Alejandro Riveira Fernández  <ariveira@gmail.com> wrote:

> Hi, i'm using a 2.6.18-rc7 in an 3880+ X2 AM2 with an uli 1697 chipset
> and i'm seeing this on the logs
> 
> Sep 18 12:49:34 localhost last message repeated 17 times
> Sep 18 12:49:40 localhost last message repeated 3 times
> Sep 18 12:49:44 localhost kernel: set_rtc_mmss: can't update from 110 to 49
> Sep 18 12:49:57 localhost last message repeated 8 times
> Sep 18 12:50:01 localhost kernel: set_rtc_mmss: can't update from 110 to 50
> Sep 18 12:50:32 localhost last message repeated 17 times
> Sep 18 12:50:41 localhost last message repeated 4 times
> Sep 18 12:50:42 localhost kernel: set_rtc_mmss: can't update from 111 to 50

That code hasn't really changed in a long time.  Are you able to determine
approximately which kernel version introduced this problem?

Thanks.  
