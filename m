Return-Path: <linux-kernel-owner+w=401wt.eu-S1752356AbWL1Ovg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbWL1Ovg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 09:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754863AbWL1Ovg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 09:51:36 -0500
Received: from il.qumranet.com ([62.219.232.206]:56621 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbWL1Ovg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 09:51:36 -0500
Message-ID: <4593D9F5.6010807@argo.co.il>
Date: Thu, 28 Dec 2006 16:51:33 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jeff Chua <jeff.chua.linux@gmail.com>
CC: Dor Laor <dor.laor@qumranet.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: open /dev/kvm: No such file or directory
References: <b6a2187b0612280508t24e0a740nd1aabdfeb706fbec@mail.gmail.com>	 <64F9B87B6B770947A9F8391472E0321609AB0D35@ehost011-8.exch011.intermedia.net> <b6a2187b0612280638o3d7c48ecn13b5dece8395b41a@mail.gmail.com>
In-Reply-To: <b6a2187b0612280638o3d7c48ecn13b5dece8395b41a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
>
>> It's a dynamic misc device, you don't need to create it.
>
> But it'll be nice to be able to manually create the device as I
> normally mount "/" as read-only?
>

udev is the best solution here.  It works with read-only root as it 
mounts tmpfs on /dev.

-- 
error compiling committee.c: too many arguments to function

