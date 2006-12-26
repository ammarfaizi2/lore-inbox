Return-Path: <linux-kernel-owner+w=401wt.eu-S1753367AbWLZJEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbWLZJEE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 04:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbWLZJEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 04:04:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:55253 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbWLZJEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 04:04:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lYXRiUk+z44SYHIIVx90o32pJ+cBkt0mSMqlNML3KpOq0iTLoAlTGJVhcPH5VPRLHPOMORQD992m9XlMxu7EuCkw/ASr11xvlOyYzTGupCKQ0+yTtW1AnjHKVEt9ZmCrkgOgSQM8xFjdKuqkscYr16gKBHV1uYzw9zPEpS6aB4Q=
Message-ID: <67029b170612260103o9193346hde726a3f09afa57f@mail.gmail.com>
Date: Tue, 26 Dec 2006 17:03:59 +0800
From: "Zhou Yingchao" <yingchao.zhou@gmail.com>
To: "yunfeng zhang" <zyf.zeroos@gmail.com>
Subject: Re: [PATCH 2.6.16.29 1/1] memory: enhance Linux swap subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4df04b840612260018u4be268cod9886edefd25c3a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840612260018u4be268cod9886edefd25c3a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/12/26, yunfeng zhang <zyf.zeroos@gmail.com>:
> In the patch, I introduce a new page system -- pps which can improve
> Linux swap subsystem performance, you can find a new document in
> Documentation/vm_pps.txt. In brief, swap subsystem should scan/reclaim
> pages on VMA instead of zone::active list ...
   The early swap subsystem was really scan/reclaim based on mm/vma,
but now it changes to pages on active/inactive list.  Perhaps you are
not following a right direction.
-- 
Yingchao Zhou
***********************************************
 Institute Of Computing Technology
 Chinese Academy of Sciences
***********************************************
