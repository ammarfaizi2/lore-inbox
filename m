Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSIQVuP>; Tue, 17 Sep 2002 17:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264635AbSIQVuP>; Tue, 17 Sep 2002 17:50:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64776 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264631AbSIQVuO>;
	Tue, 17 Sep 2002 17:50:14 -0400
Message-ID: <3D87A4A2.6050403@mandrakesoft.com>
Date: Tue, 17 Sep 2002 17:54:42 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: akpm@digeo.com, manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
References: <3D879F59.6BDF9443@digeo.com>	<20020917.142635.114214508.davem@redhat.com>	<3D87A264.8D5F3AD2@digeo.com> <20020917.143947.07361352.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Any driver should be able to get the NAPI overhead to max out at
> 2 PIOs per packet.


Just to pick nits... my example went from 2 or 3 IOs [depending on the 
presence/absence of a work loop] to 6 IOs.

Feel free to re-read my message and point out where an IO can be 
eliminated...

	Jeff



