Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbVJQPER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVJQPER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVJQPER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:04:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:38123 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751379AbVJQPER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:04:17 -0400
Message-ID: <4353BB87.1030006@us.ibm.com>
Date: Mon, 17 Oct 2005 09:56:07 -0500
From: "V. Ananda Krishnan" <mansarov@us.ibm.com>
User-Agent: Thunderbird 1.4.1 (X11/20051006)
MIME-Version: 1.0
To: Damir Perisa <damir.perisa@solnet.ch>
CC: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 - drivers/serial/jsm/jsm_tty.c: no member named
 'flip'
References: <20051016154108.25735ee3.akpm@osdl.org> <200510171229.57785.damir.perisa@solnet.ch>
In-Reply-To: <200510171229.57785.damir.perisa@solnet.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Please give details of the distro and the compiler version that you 
used.  Are you building the driver as a module?

Thanks,
V. Ananda Krishnan
Damir Perisa wrote:
> just found that jsm-tty is still not compiling:
>
>   LD      drivers/serial/jsm/built-in.o
>   CC [M]  drivers/serial/jsm/jsm_driver.o
>   CC [M]  drivers/serial/jsm/jsm_neo.o
>   CC [M]  drivers/serial/jsm/jsm_tty.o
> drivers/serial/jsm/jsm_tty.c: In function 'jsm_input':
> drivers/serial/jsm/jsm_tty.c:592: error: 'struct tty_struct' has no member named 'flip'
> drivers/serial/jsm/jsm_tty.c:619: error: 'struct tty_struct' has no member named 'flip'
> drivers/serial/jsm/jsm_tty.c:620: error: 'struct tty_struct' has no member named 'flip'
> drivers/serial/jsm/jsm_tty.c:623: error: 'struct tty_struct' has no member named 'flip'
> ...
>
> greetings,
> Damir
>
>   

