Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTFPWj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264403AbTFPWi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:38:29 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:56057 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264396AbTFPWhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:37:39 -0400
Message-ID: <3EEE49BA.6070401@us.ibm.com>
Date: Mon, 16 Jun 2003 15:50:34 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: janiceg@us.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       stekloff@us.ibm.com, girouard@us.ibm.com, lkessler@us.ibm.com,
       kenistonj@us.ibm.com, jgarzik@pobox.com
Subject: Re: patch for common networking error messages
References: <3EEE28DE.6040808@us.ibm.com>	<3EEE40F1.4030107@us.ibm.com> <20030616.151308.55864910.davem@redhat.com>
In-Reply-To: <20030616.151308.55864910.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Nivedita Singhvi <niv@us.ibm.com>
>    Date: Mon, 16 Jun 2003 15:13:05 -0700
>    
>    I'd certainly like to see messages from the driver when the
>    card enters/leaves promiscuous mode,
> 
> egrep "promiscuous mode" net/core/dev.c | grep printk


Yeah, but dev_mc_upload() doesnt return any status ;).
(For those of us who distrust hw (Sorry Scott! :))).

But it was just my example, I assure you. I'm not
holding up a flag in the wind on this particular nit.
I do see positives in the feature as a whole though.
It would be a shame to get grounded for minor things..

thanks,
Nivedita



