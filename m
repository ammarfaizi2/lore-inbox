Return-Path: <linux-kernel-owner+w=401wt.eu-S965230AbWL3A7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWL3A7j (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 19:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbWL3A7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 19:59:39 -0500
Received: from terminus.zytor.com ([192.83.249.54]:54088 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965230AbWL3A7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 19:59:38 -0500
Message-ID: <4595B9DD.4040906@zytor.com>
Date: Fri, 29 Dec 2006 16:59:09 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: Jeff Chua <jeff.chua.linux@gmail.com>, Dor Laor <dor.laor@qumranet.com>,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: open /dev/kvm: No such file or directory
References: <b6a2187b0612280508t24e0a740nd1aabdfeb706fbec@mail.gmail.com>	 <64F9B87B6B770947A9F8391472E0321609AB0D35@ehost011-8.exch011.intermedia.net>	 <b6a2187b0612280638o3d7c48ecn13b5dece8395b41a@mail.gmail.com>	 <4593D9F5.6010807@argo.co.il> <b6a2187b0612280742x1b613849ye23aca38c71a5871@mail.gmail.com> <4593E7EB.7070801@argo.co.il>
In-Reply-To: <4593E7EB.7070801@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> 
> Greg, /dev/kvm is a MISC_DYNAMIC_MINOR device.  Is there any way of 
> using it without udev?  Should I allocate a static number?
> 

Especially for something like /dev/kvm, I think it would make sense to 
allocate a static number for it.

	-hpa

