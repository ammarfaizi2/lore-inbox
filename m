Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVB1BpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVB1BpM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 20:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVB1BpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 20:45:12 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:17374 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261538AbVB1BpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 20:45:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FcWuY+2GE/o+rVajlRp159+KpE4EH6ZyoMiH/g+04HnQosjfbE2L7D6ittZDNljCd2yfZ9NSr5CgLhCTkfupirliR4VKt2E5C5URQhUkNWZqFVm8syTK17ntWV8enWqY/fTpj/e2VR0Ifm0sD9bGwURDZoHST6uLxXXBcWNc9jM=
Message-ID: <29495f1d05022717454bc81cfa@mail.gmail.com>
Date: Sun, 27 Feb 2005 17:45:06 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Wen Xiong <wendyx@us.ibm.com>
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <42225A64.6070904@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_driver.h linux-2.6.9.new/drivers/serial/jsm/jsm_driver.h
> --- linux-2.6.9.orig/drivers/serial/jsm/jsm_driver.h    1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/jsm_driver.h     2005-02-27 17:14:44.747952016 -0600

<snip>

> +#define jsm_jiffies_from_ms(a) (((a) * HZ) / 1000)

Please use the existing msecs_to_jiffies(), which has both a more
sensible name and is correct.

Thanks,
Nish
