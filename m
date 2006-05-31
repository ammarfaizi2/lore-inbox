Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWEaUan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWEaUan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWEaUal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:30:41 -0400
Received: from es335.com ([67.65.19.105]:61970 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S964782AbWEaUah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:30:37 -0400
Subject: Re: [PATCH 2/2] iWARP Core Changes.
From: Steve Wise <swise@opengridcomputing.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adaodxeypfd.fsf@cisco.com>
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	 <20060531182654.3308.41372.stgit@stevo-desktop> <adaodxeypfd.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 31 May 2006 15:30:35 -0500
Message-Id: <1149107435.7469.7.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 12:17 -0700, Roland Dreier wrote:
>  > +EXPORT_SYMBOL(copy_addr);
> 
> I think if you want to export this, it needs a less generic name
> (something with an rdma_ prefix probably).  Otherwise it's going to
> collide someday...

ok.


The function is needed by the iwcm module, so that's why we exported it.
I could change the name to rdma_copy_addr(), or make the function a
static inline in a header file since its kinda small anyway...

Any preference?


