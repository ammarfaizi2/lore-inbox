Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313054AbSDSVpq>; Fri, 19 Apr 2002 17:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313062AbSDSVpp>; Fri, 19 Apr 2002 17:45:45 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:41120 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313054AbSDSVpo>; Fri, 19 Apr 2002 17:45:44 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200204192145.g3JLjhl10107@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.19pre7-ac1
To: aquamodem@ameritech.net
Date: Fri, 19 Apr 2002 17:45:43 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3CC0790F.2070400@ameritech.net> from "watermodem" at Apr 19, 2002 03:07:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> drivers/char/Config.in: 265: can't handle 
> dep_bool/dep_mbool/dep_tristate condition

Yep - should be a bool not a dep_bool. Fixed  - thanks
