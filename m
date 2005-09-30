Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVI3CQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVI3CQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVI3CQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:16:45 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:44683 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932411AbVI3CQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:16:44 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: khali@linux-fr.org, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: 2.6.14-rc2-mm2
Date: Fri, 30 Sep 2005 12:16:17 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <um7pj19n3et32jcergv4ep2qunpu6vlmjl@4ax.com>
References: <20050929143732.59d22569.akpm@osdl.org> <20050930010931.5beb174e@werewolf.able.es>
In-Reply-To: <20050930010931.5beb174e@werewolf.able.es>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2005 01:09:31 +0200, "J.A. Magallon" <jamagallon@able.es> wrote:

>Another issue. Is there any divisor value for fans hardcoded intially ?
>I have 3 fans in my mobo, and 2 report 0 RPM until I put the divisor at 8
>This fans are two for the xeons, and one for the box. Strangely, the fans that
>are misread are the one for the board and one of the xeons ?

I've done auto fan divisor, see drivers/hwmon/adm9240.c for example and 
  http://bugsplatter.mine.nu/hwmon/autofan/
for info, test results.

Cheers,
Grant.
