Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268515AbUJMGP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268515AbUJMGP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 02:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268496AbUJMGP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 02:15:56 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:49633 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268483AbUJMGPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 02:15:48 -0400
Message-ID: <b2fa632f0410122315753f8886@mail.gmail.com>
Date: Wed, 13 Oct 2004 11:45:43 +0530
From: Raj <inguva@gmail.com>
Reply-To: Raj <inguva@gmail.com>
To: eshwar <eshwar@moschip.com>
Subject: Re: Write USB Device Driver entry not called
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <005101c4b763$5e3cba60$41c8a8c0@Eshwar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <005101c4b763$5e3cba60$41c8a8c0@Eshwar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>   devfd = open("/dev/usb/dabusb10",O_APPEND | S_IRUSR| S_IWUSR );

Did your open() succeed here ??? i guess S_IRUSR etc is used when you
create a new file and not when you open a new one.

>   if ( write(devfd,send,512) < 0) {
>        printf ("write Failed\n");
>        return  -1;
>   }

well , if open fails above, then....

-- Raj
