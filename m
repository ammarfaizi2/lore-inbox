Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWH1BlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWH1BlK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 21:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWH1BlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 21:41:10 -0400
Received: from mx.pathscale.com ([64.160.42.68]:49292 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932318AbWH1BlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 21:41:09 -0400
Message-ID: <44F249B4.501@pathscale.com>
Date: Sun, 27 Aug 2006 18:41:08 -0700
From: Robert Walsh <rjwalsh@pathscale.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 22 of 23] IB/ipath - print warning if LID not acquired
 within one minute
References: <44EF6053.4010006@pathscale.com>	<20060826193126.GF21168@mellanox.co.il> <adalkp9rf2j.fsf@cisco.com>
In-Reply-To: <adalkp9rf2j.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Michael> Looks like your devices are all single-port. With a multi
>     Michael> port device it is quite common to have one port down.
> 
> My reading of the patch is that it warns if the link is up physically
> but does not come up logically.  Which would still be reasonable for a
> multi-port device.
> 
> But I am still wondering about when this is really useful.

Well, either you think it is or it isn't.  We like it: it's easier than 
pointing customers at something in /sys.

Regards,
  Robert.
