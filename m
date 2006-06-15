Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWFODHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWFODHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 23:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWFODHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 23:07:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:32420 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751293AbWFODHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 23:07:47 -0400
Message-ID: <4490CD79.2070707@in.ibm.com>
Date: Thu, 15 Jun 2006 08:31:13 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Sturtivant <csturtiv@sgi.com>
Subject: Re: ON/OFF control of taskstats accounting data at do_exit
References: <449093D6.6000806@engr.sgi.com>
In-Reply-To: <449093D6.6000806@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> Hi Balbir and Shailabh,
> 
> I propose we add the capability to turn ON/OFF the multicase of
> taskstats accounting data at do_exit().
> 
> This would allow 'chkconfig taskstats' like of control similar
> to 'chkconfig acct' for BSD accounting. Sometimes sysadmins would
> wish to turn off sending accounting data to the multicast socket.
> We have seen many situations that our CSA customers need to turn
> off CSA for a period of time.

If we need to turn the entire sending of stats off, then closing
the socket listening on the multicast group should turn off sending
of accounting information. Am I missing something?

> 
> I think this feature is very important to this new interface.
> 
> Thanks,
>  - jay
> 



-- 
	Regards,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
