Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968102AbWLEKrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968102AbWLEKrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 05:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968106AbWLEKrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 05:47:39 -0500
Received: from mail-relay-02.mailcluster.net ([85.249.135.243]:60114 "EHLO
	mail-relay-02.mailcluster.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968102AbWLEKrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 05:47:39 -0500
Message-ID: <45754E27.9020609@vlnb.net>
Date: Tue, 05 Dec 2006 13:47:03 +0300
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060212 Fedora/1.7.12-5
X-Accept-Language: en-us, ru, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: scst support for kernels above 2.6.15
References: <4574ABB1.8000301@wolfmountaingroup.com>
In-Reply-To: <4574ABB1.8000301@wolfmountaingroup.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> I have noticed that scsi_do_req has apparently been obsoleted in 2.6.18 
> and above.  Is scst and target support for FC-AL going to
> remain supported and/or merged at some point?   If so, what is planned 
> for scst support for later kernels?

Jeff, I don't know why you ask here and not in scst-devel mailing list,
but SCST has beed updated to use scsi_execute_async() instead of
scsi_do_req() in 2.6.18+ for quite a while. Yes, scst is going to be
supported in the future.

Vlad

> Jeff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

