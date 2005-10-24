Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVJXPlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVJXPlP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVJXPlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:41:15 -0400
Received: from qproxy.gmail.com ([72.14.204.193]:11542 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751104AbVJXPlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:41:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=gMim473IPex7w5Fg+NU3n3m1ZVTuIwUfL38itcXDNmE0zhA8umQnt3onlFFe9IAQFa2yyCKsqJaFD5iH6k5m26SDzchecWRAnYJt3NZ15S+otEzFDV+dmE5GjGPivQuhLlf6DHVFyX1Tl/J5acu7C5FJPeSPR2SRUk2LBlN553k=
Subject: Re: 2.6.14-rc5-mm1
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
References: <20051024014838.0dd491bb.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 08:40:34 -0700
Message-Id: <1130168434.6831.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 01:48 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/

Compile problems. 

Thanks,
Badari

elm3b29:/usr/src/linux-2.6.14-rc5 # make -j40 modules
  CHK     include/linux/version.h
  CC [M]  drivers/serial/jsm/jsm_tty.o
drivers/serial/jsm/jsm_tty.c: In function `jsm_input':
drivers/serial/jsm/jsm_tty.c:592: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:619: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:620: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:623: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:624: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:667: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:668: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:669: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:670: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:671: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:672: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:674: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:677: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:680: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:681: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:682: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:691: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:692: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:693: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:694: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:695: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:696: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:698: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:701: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:742: error: structure has no member named
`flip'
drivers/serial/jsm/jsm_tty.c:742: error: structure has no member named
`flip'
make[3]: *** [drivers/serial/jsm/jsm_tty.o] Error 1
make[2]: *** [drivers/serial/jsm] Error 2
make[1]: *** [drivers/serial] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2



