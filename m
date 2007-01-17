Return-Path: <linux-kernel-owner+w=401wt.eu-S932245AbXAQOGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbXAQOGN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 09:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbXAQOGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 09:06:13 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:53469 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245AbXAQOGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 09:06:12 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B3N3gSYl3vwZ9+TxqLKdLPBwIAfd8Y4A6gqYhiilT9MYP81GrQqRUhMoGxHkvj86Heks6Px3uUZ5JoMCy7Y9oAQK7gMgnRUG7/YxxqoIk0C5D3ZQzFV1l+edQSUjel/zTW0xbqBl+LXJAtq0pJl00tqSgF5nJxEtYtVWs4SkBTY=
Message-ID: <9e0cf0bf0701170606x32e701e7i460aba13a2ae5bfd@mail.gmail.com>
Date: Wed, 17 Jan 2007 16:06:10 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Tomasz Chmielewski" <mangoo@wpkg.org>
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45AE2AF3.5070706@wpkg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45AE1D65.4010804@wpkg.org>
	 <9e0cf0bf0701170537s4bb663a1j2d45b4013da81fbc@mail.gmail.com>
	 <45AE2AF3.5070706@wpkg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/07, Tomasz Chmielewski <mangoo@wpkg.org> wrote:
> Another obstacle would be to place the initramfs image on the same
> partition as the kernel (normally, I dd kernel to /dev/mtd1).

As far as I know you can embed the initramfs into the kernel image using
CONFIG_INITRAMFS_SOURCE.

http://www.timesys.com/timesource/initramfs.htm

Best Regards,
Alon Bar-Lev.
