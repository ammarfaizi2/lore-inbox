Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132851AbRDIVUW>; Mon, 9 Apr 2001 17:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132852AbRDIVUN>; Mon, 9 Apr 2001 17:20:13 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:46095 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132851AbRDIVUA>; Mon, 9 Apr 2001 17:20:00 -0400
Message-Id: <200104092119.f39LJts17813@aslan.scsiguy.com>
To: lists@sapience.com
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx 6.1.10 and 2.4.4-pre1 
In-Reply-To: Your message of "Sun, 08 Apr 2001 00:11:32 EDT."
             <20010408001132.A28840@sapience.com> 
Date: Mon, 09 Apr 2001 15:19:55 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Apr  7 19:56:13 snap kernel:   Vendor: SEAGATE   Model: ST318275LW        Rev:
> 0001

I seem to recall this being a very buggy firmware version.  You should
check with Seagate to see if they have something new.  If this is the
firmware I'm thinking of, the driver should perform correctly if you
disable write caching.  You can do this via the SCSI-Select menu for
the controller.

--
Justin
