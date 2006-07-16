Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWGPUDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWGPUDp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 16:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWGPUDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 16:03:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:4646 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932094AbWGPUDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 16:03:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O+RxpkYIdEtqhRHmjHcaVI/JSYrh9BeAcgjMdpldAeFa/h37o6NWpQzy854u8xWOrbXqaL+le0nrT/JQfZlqUjg/ClhGiPCwYEbenTpEf4r6kAxsF0MhQU0ZnXP4yxzYTsRTzCIX0vrjDft1WqTbO3O5eg04HHvDYUVcToHutMI=
Message-ID: <427c54c0607161303r416c0dddt916a2b635c7431c5@mail.gmail.com>
Date: Sun, 16 Jul 2006 15:03:42 -0500
From: "Daniel De Graaf" <danieldegraaf@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Rescan IDE interface when no IDE devices are present
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1153077903.5905.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <427c54c0607161212m714f4faew60b8615e06ac885a@mail.gmail.com>
	 <1153077903.5905.35.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> If you have ide1, you have both hdc and hdd (slave of hdc) unles sit's
> not really IDE ...
>
> Ben.

Yes, I have /dev/hdd, but no device is ever present there. I also have
/dev/sda for the SATA hard disk, but do not think it is useful for
HDIO_SCAN_HWIF or HWIO_UNREGISTER_HWIF ioctls.

- Daniel
