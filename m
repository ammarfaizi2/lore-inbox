Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbTHUHqh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 03:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTHUHq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 03:46:27 -0400
Received: from mail2.uu.nl ([131.211.16.76]:26806 "EHLO mail2.uu.nl")
	by vger.kernel.org with ESMTP id S262496AbTHUHqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 03:46:24 -0400
Subject: Re: [PATCH] 2.6.0-test3 zoran driver update
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030821010812.A6961@electric-eye.fr.zoreil.com>
References: <1061414594.1320.97.camel@localhost.localdomain>
	 <20030821010812.A6961@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Message-Id: <1061452050.4235.222.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 21 Aug 2003 09:47:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francois,

thanks for the comments, I'll definately look at them. One thing is
unclear:

On Thu, 2003-08-21 at 01:08, Francois Romieu wrote:
> - {adv7170/adv7175/bt819/saa7110/saa7185}_detect_client()
>   for each of these functions, two error exit path leak on locally allocated
>   variable "channel".

There is no variable 'channel' in these functions. I've double checked
these functions, too, and can't find any obvious leaks in them at all.
Could you please re-check?

Thanks again,
Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

