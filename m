Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVHDVmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVHDVmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVHDVkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:40:36 -0400
Received: from mx2.netapp.com ([216.240.18.37]:10895 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S262735AbVHDVii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:38:38 -0400
X-IronPort-AV: i="3.95,168,1120460400"; 
   d="scan'208"; a="300351852:sNHT16688364"
Date: Thu, 4 Aug 2005 17:38:35 -0400 (EDT)
From: James Lentini <jlentini@netapp.com>
X-X-Sender: jlentini@jlentini-linux.nane.netapp.com
To: Roland Dreier <rolandd@cisco.com>
cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] [RFC] Move InfiniBand .h files
In-Reply-To: <52iryla9r5.fsf@cisco.com>
Message-ID: <Pine.LNX.4.61.0508041654370.5243@jlentini-linux.nane.netapp.com>
References: <52iryla9r5.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Aug 2005, Roland Dreier wrote:

> I would like to get people's reactions to moving the InfiniBand .h
> files from their current location in drivers/infiniband/include/ to
> include/linux/rdma/.  If we agree that this is a good idea then I'll
> push this change as soon as 2.6.14 starts.

I think it is a good idea.

> The advantages of doing this are:
>
>  - The headers become more easily accessible to other parts of the
>    tree that might want to use IB support.  For example, an NFS/RDMA
>    client probably wants to live under fs/

net/sunrpc/ has also been proposed.
