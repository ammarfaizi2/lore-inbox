Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbSIZIJx>; Thu, 26 Sep 2002 04:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262240AbSIZIJx>; Thu, 26 Sep 2002 04:09:53 -0400
Received: from [203.117.131.12] ([203.117.131.12]:50124 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262239AbSIZIJx>; Thu, 26 Sep 2002 04:09:53 -0400
Message-ID: <3D92C206.2050905@metaparadigm.com>
Date: Thu, 26 Sep 2002 16:15:02 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@pobox.com, wli@holomorphy.com, axboe@suse.de, akpm@digeo.com,
       linux-kernel@vger.kernel.org, patman@us.ibm.com, andmike@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
References: <3D92B450.2090805@pobox.com>	<20020926.001343.57159108.davem@redhat.com>	<3D92B83E.3080405@pobox.com> <20020926.003503.35357667.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/26/02 15:35, David S. Miller wrote:
>    From: Jeff Garzik <jgarzik@pobox.com>
>    Date: Thu, 26 Sep 2002 03:33:18 -0400
>    
>    Just dug up the URL, in case anybody is interested:
>    http://www.feral.com/isp.html

Would be nice to have a stable qlogic driver in the main kernel.

Although last time i tried Matt Jabob's driver, it locked up
after 30 seconds of running bonnie. At least with Qlogic's
driver I can run bonnie and cerberus continuously for 2 weeks
with no problems (although this may have been because
Matt's driver ignored the command queue throttle set in the
qlogic cards BIOS).

> Note there is a bitkeeper tree to pull from even :-)

The qlogic HBAs are a real problem in choosing which driver
to use out of:

in kernel qlogicfc
Qlogic's qla2x00 v4.x, v5.x, v6.x
Matthew Jacob's isp_mod

What are people out there using with their QLA 2200/2300s?

~mc

