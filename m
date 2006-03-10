Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWCJOAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWCJOAh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 09:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWCJOAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 09:00:37 -0500
Received: from mx2.netapp.com ([216.240.18.37]:27653 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1751178AbWCJOAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 09:00:36 -0500
X-IronPort-AV: i="4.02,181,1139212800"; 
   d="scan'208"; a="366008684:sNHT19185308"
Message-Id: <7.0.1.0.2.20060310085616.040c1290@netapp.com>
X-Mailer: QUALCOMM Windows Eudora Version 7.0.1.0
Date: Fri, 10 Mar 2006 08:58:43 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
From: "Talpey, Thomas" <Thomas.Talpey@netapp.com>
Subject: Re: [openib-general] Re: Revenge of the sysfs maintainer! (was
  Re: [PATCH 8 of 20] ipath - sysfs support for core driver)
Cc: Greg KH <gregkh@suse.de>, akpm@osdl.org, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       davem@davemloft.net
In-Reply-To: <1141966693.14517.20.camel@camp4.serpentine.com>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain>
 <adapskvfbqe.fsf@cisco.com>
 <1141947143.10693.40.camel@serpentine.pathscale.com>
 <20060310003513.GA17050@suse.de>
 <1141951589.10693.84.camel@serpentine.pathscale.com>
 <20060310010050.GA9945@suse.de>
 <1141966693.14517.20.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 10 Mar 2006 14:00:28.0808 (UTC) FILETIME=[FCE9B080:01C6444A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:58 PM 3/9/2006, Bryan O'Sullivan wrote:
>I'd like a mechanism that is (a) always there (b) easy for kernel to use
>and (c) easy for userspace to use.  A sysfs file satisfies a, b, and c,
>but I can't use it; a sysfs bin file satisfies all three (a bit worse on
>b), but I can't use it; debugfs isn't there, so I can't use it.
>
>That leaves me with few options, I think.  What do you suggest?  (Please
>don't say netlink.)

mmap()?

Tom.

