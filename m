Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTFDDO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 23:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTFDDO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 23:14:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42393 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262671AbTFDDOY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 23:14:24 -0400
Message-ID: <3EDD672C.2000701@pobox.com>
Date: Tue, 03 Jun 2003 23:27:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: Regarding SET_NETDEV_DEV
References: <20030603175921.GE2079@gtf.org> <20030603.200944.78736971.davem@redhat.com>
In-Reply-To: <20030603.200944.78736971.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Jeff Garzik <jgarzik@pobox.com>
>    Date: Tue, 3 Jun 2003 13:59:21 -0400
> 
>    For janitors and other developers placing this in net drivers...
>    please don't :)  This can be done in upper layers, accomplishing the
>    same goal without changing the low-level net driver code at all.
>    
> Don't say something can be done without showing exactly
> how :-)
> 
> How does register_netdevice() know that the device is "whatever" and
> where to get the generic device struct from?


Doh!  You are totally right -- it can't get the association any other 
way.  Folks, ignore me :)

	Jeff



