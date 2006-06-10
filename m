Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWFJKXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWFJKXj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWFJKXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:23:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:50785 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751479AbWFJKXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:23:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SBcDaFOEELeNjEGt3GZuB/7fVeoRSYAF35EJw/NXKCxWJ7vKgWgkFU7geN2XeoX469CX49Tpwuu+kq/Rb+TRerh2g8xzgM6OysbarPmAwMVw5z8DK51z6dzMSko7nMVUip/Fprimo465rNN+4D7P6wPVbPs+jVRe84FuP8rmSnY=
Message-ID: <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com>
Date: Sat, 10 Jun 2006 12:23:37 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.16-rc6-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060609214024.2f7dd72c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060609214024.2f7dd72c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/06/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/
>

I get a lot of "BUG: using smp_processor_id() in preemptible"

Real Time Clock Driver v1.12ac
printk: 22314 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: restorecon/393
caller is __handle_mm_fault+0x2b/0x20d
 [<c0103ba8>] show_trace+0xd/0xf
 [<c0103c7a>] dump_stack+0x17/0x19
 [<c0203bcc>] debug_smp_processor_id+0x8c/0xa0
 [<c0160e60>] __handle_mm_fault+0x2b/0x20d
 [<c0116f7b>] do_page_fault+0x226/0x61f
 [<c0103959>] error_code+0x39/0x40

Here is dmesg http://www.stardust.webpages.pl/files/mm/2.6.17-rc6-mm2/mm-dmesg
Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc6-mm2/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
