Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261396AbSIZRgw>; Thu, 26 Sep 2002 13:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSIZRgw>; Thu, 26 Sep 2002 13:36:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62140 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261396AbSIZRgv>; Thu, 26 Sep 2002 13:36:51 -0400
Date: Thu, 26 Sep 2002 10:41:48 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Michael Clark <michael@metaparadigm.com>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@pobox.com,
       wli@holomorphy.com, axboe@suse.de, akpm@digeo.com,
       linux-kernel@vger.kernel.org, patman@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926174148.GB1843@beaverton.ibm.com>
References: <3D92B450.2090805@pobox.com> <20020926.001343.57159108.davem@redhat.com> <3D92B83E.3080405@pobox.com> <20020926.003503.35357667.davem@redhat.com> <3D92C206.2050905@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D92C206.2050905@metaparadigm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark [michael@metaparadigm.com] wrote:
> The qlogic HBAs are a real problem in choosing which driver
> to use out of:
> 
> in kernel qlogicfc
> Qlogic's qla2x00 v4.x, v5.x, v6.x
> Matthew Jacob's isp_mod
> 

We have had good results using the Qlogic's driver. We are currently
running the v6.x version with Failover tunred off on 23xx cards. We have
run a lot on > 4GB systems also.

-andmike
--
Michael Anderson
andmike@us.ibm.com

